import 'dart:developer';

import 'package:chat_together/models/chat_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class APIs {
  static FirebaseAuth auth = FirebaseAuth.instance;

  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static FirebaseStorage storage = FirebaseStorage.instance;

  static User get user => auth.currentUser!;

  static late ChatUser me;
 
  static Future<bool> userExist() async {
    return (await firestore
            .collection('users')
            .doc(auth.currentUser!.uid)
            .get())
        .exists;
  }

  static Future<void> getSelfInfor() async {
    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .get()
        .then((_user) async {
      if (_user.exists) {
        me = ChatUser.fromJson(_user.data()!);
        log('APIs - MY INFOR: ${me.toJson()}');
      } else {
        log('dont exist');
        await createUser().then((value) => getSelfInfor());
      }
    });
  }

  static Future<void> createUser() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    final chatUser = ChatUser(
        isOnline: false,
        id: user.uid,
        pushToken: '',
        imageUrl: user.photoURL.toString(),
        email: user.email.toString(),
        username: user.displayName.toString(),
        lastActive: time);

    return await firestore
        .collection('users')
        .doc(user.uid)
        .set(chatUser.toJson());
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers() {
    return firestore
        .collection('users')
        .where('id', isNotEqualTo: user.uid)
        .snapshots();
  }

  static Future<void> updateUser() async {
    await firestore.collection('users').doc(user.uid).update({
      'username': me.username,
      //'image_url': me.imageUrl
    });
  }
}
