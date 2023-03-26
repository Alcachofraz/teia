import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:teia/models/user.dart';
import 'package:teia/services/firebase/firestore_utils.dart';

class UserManagementService {
  /// Try to create user, in case it doesn't exists. If
  /// a user with the same uid already exists, this function
  /// does nothing, and returns false.
  static Future<bool> tryCreateUser(auth.User user) async {
    return await FirebaseUtils.firestore.runTransaction((transaction) async {
      var doc = await transaction.get(FirebaseUtils.firestore.collection('user').doc(user.uid));
      if (!doc.exists) {
        await FirebaseUtils.firestore.collection('user').doc(user.uid).set(
              User(
                user.uid,
                user.email!.substring(0, user.email!.indexOf('@')),
                user.email!,
                null,
              ).toMap(),
            );
        return true;
      }
      return false;
    });
  }

  /// Update photo url for user [uid].
  static Future<void> userSetPhotoUrl(String uid, String url) async {
    await FirebaseUtils.firestore.collection('user').doc(uid).set({'url': url});
  }

  /// Update name for user [uid].
  static Future<void> userSetName(String uid, String name) async {
    await FirebaseUtils.firestore.collection('user').doc(uid).set({'name': name});
  }
}