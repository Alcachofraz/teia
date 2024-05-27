import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teia/models/group.dart';
import 'package:teia/models/user_state.dart';
import 'package:teia/screens/group/models/user_info.dart';
import 'package:teia/screens/home/popups/edit_user/edit_user.dart';
import 'package:teia/services/art_service.dart';
import 'package:teia/services/authentication_service.dart';
import 'package:teia/services/group_management_service.dart';
import 'package:teia/services/user_management_service.dart';

class GroupController extends GetxController {
  final GroupManagementService groupManagementService =
      Get.put(GroupManagementService());
  final UserManagementService userManagementService =
      Get.put(UserManagementService());
  final Rxn<Group> group = Rxn<Group>();
  final RxList<UserInfo> userInfo = <UserInfo>[].obs;

  RxBool loading = false.obs;
  late Color userBoxColor;
  late Color storyBoxColor;
  RxBool loadingRole = false.obs;
  RxBool allowed = false.obs;

  late StreamSubscription<Group> groupSubscription;

  @override
  void onInit() async {
    loading.value = true;
    userBoxColor = ArtService.value.pastel();
    storyBoxColor = ArtService.value.pastel();
    String groupName = Get.parameters['group'] ?? '';
    if (groupName.isNotEmpty) {
      groupSubscription = groupManagementService.groupStream(groupName).listen(
        (Group? newGroup) async {
          if (newGroup != null) {
            allowed.value = newGroup.users.contains(
              AuthenticationService.value.user?.uid,
            );
            if (allowed.value) {
              group.value = newGroup;
              userInfo.clear();
              newGroup.userState.forEach((key, value) {
                userInfo.add(UserInfo(
                  isSelf: key == AuthenticationService.value.user?.uid,
                  color: userBoxColor,
                  state: value,
                ));
              });
            }
          }
          loading.value = false;
        },
      );
    }

    super.onInit();
  }

  @override
  void onClose() {
    groupSubscription.cancel();
    super.onClose();
  }

  Future<void> onRoleChanged(Role? role) async {
    loadingRole.value = true;
    if (role != null && group.value != null) {
      await Get.put(GroupManagementService())
          .changeRole(group.value!.name, role);
    }
    loadingRole.value = false;
  }

  Future<void> onTapEditUser() async {
    await launchEditUserPopup(Get.context!, group.value!);
  }
}
