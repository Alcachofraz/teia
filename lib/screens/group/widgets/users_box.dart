import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:teia/models/group.dart';
import 'package:teia/models/user_state.dart';
import 'package:teia/screens/group/models/user_info.dart';
import 'package:teia/screens/group/widgets/status_icon.dart';
import 'package:teia/services/art_service.dart';
import 'package:teia/services/authentication_service.dart';
import 'package:teia/utils/utils.dart';

class UsersBox extends StatelessWidget {
  const UsersBox({
    super.key,
    required this.info,
    required this.color,
    this.loadingRole = false,
    this.onRoleChanged,
    this.onTapEditUser,
    this.group,
  });

  final List<UserInfo> info;
  final Color color;
  final bool loadingRole;
  final Function(Role?)? onRoleChanged;
  final Function()? onTapEditUser;
  final Group? group;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Critters',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Gap(4),
        Expanded(
          child: Material(
            color: Utils.pageEditorSheetColor,
            elevation: 2,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    for (final UserInfo userInfo in info)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          children: [
                            Expanded(
                              child: Stack(
                                children: [
                                  Material(
                                    color: Colors.white,
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      side: BorderSide(
                                        color: userInfo.color,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Image.asset(
                                              ArtService.value.assetPath(
                                                userInfo.state.avatar,
                                              ),
                                              height: 48,
                                            ),
                                          ),
                                          const Gap(12),
                                          Expanded(
                                            child: Text(
                                              userInfo.state.name,
                                              textAlign: TextAlign.left,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          const Spacer(),
                                          Expanded(
                                            child: Text(
                                              userInfo.state.role
                                                  .toString()
                                                  .toUpperCase(),
                                              textAlign: TextAlign.right,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: userInfo.color,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          const Gap(12),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned.fill(
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap:
                                            group!.state == GroupState.idle &&
                                                    userInfo.state.uid ==
                                                        AuthenticationService
                                                            .value.uid
                                                ? onTapEditUser
                                                : null,
                                        borderRadius: BorderRadius.circular(8),
                                        child: const SizedBox.expand(),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const Gap(12),
                            StatusIcon(
                              userState: userInfo.state,
                              group: group!,
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
