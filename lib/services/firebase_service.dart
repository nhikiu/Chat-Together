import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../models/chat_user.dart';
import '../models/message.dart';

class FirebaseService {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static FirebaseStorage storage = FirebaseStorage.instance;
  static FirebaseMessaging fMessaging = FirebaseMessaging.instance;
  static User get user => auth.currentUser!;

  //Tạo một người dùng mới trên Firebase.
  static Future<void> createUser(ChatUser chatUser) async {
    return await firestore.collection('users').doc(user.uid).set(chatUser.toJson());
  }

  //Lấy danh sách tất cả các người dùng khác so với người dùng hiện tại.
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers() {
    return firestore.collection('users').where('id', isNotEqualTo: user.uid).snapshots();
  }

  // Cập nhật thông tin người dùng.
  static Future<void> updateUser(String username) async {
    await firestore.collection('users').doc(user.uid).update({
      'username': username,
    });
  }

  static Future<void> updateToken(String token) async {
    await firestore.collection('users').doc(user.uid).update({
      'push_token': token,
    });
  }

  //Trả về id của cuộc trò chuyện giữa người dùng hiện tại và một người dùng khác.
  static String getIdConversation(String id) {
    if (id.hashCode >= user.uid.hashCode) {
      return '${user.uid}_${id}';
    }
    return '${id}_${user.uid}';
  }

  //Lấy danh sách các tin nhắn trong cuộc trò chuyện giữa người dùng hiện tại và một người dùng khác.
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(
      ChatUser chatuser) {
    return firestore
        .collection('chats/${getIdConversation(chatuser.id)}/messages/')
        .orderBy('createAt', descending: true)
        .snapshots();
  }

  //Lấy tin nhắn gần đây nhất trong cuộc trò chuyện giữa người dùng hiện tại và một người dùng khác.
  static Stream<QuerySnapshot<Map<String, dynamic>>> getLastMessage(
      ChatUser chatuser) {
    return firestore
        .collection('chats/${getIdConversation(chatuser.id)}/messages/')
        .orderBy('createAt', descending: true)
        .limit(1)
        .snapshots();
  }

  //Gửi một tin nhắn đến một người dùng khác.
  static Future<void> sendMessage(ChatUser chatuser, String text, Type type) async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final userData = await firestore.collection('users').doc(user.uid).get();
    final Message message = Message(
        fromid: user.uid,
        toid: chatuser.id,
        userimage: userData['image_url'],
        text: text,
        createAt: time,
        type: type,
        username: userData['username']);

    final ref = firestore.collection('chats/${getIdConversation(chatuser.id)}/messages/');

    await ref.doc(time).set(message.toJson());
  }

  //Gửi một hình ảnh đến một người dùng khác.
  static Future<void> sendImage({required ChatUser chatUser, required String image}) async {
    final ref = storage
        .ref()
        .child('image')
        .child(getIdConversation(chatUser.id))
        .child('${DateTime.now().millisecondsSinceEpoch}.jpg');
    await ref.putFile(File(image)).whenComplete(() => null);
    final urlImage = ref.getDownloadURL();
    await sendMessage(chatUser, await urlImage, Type.image);
  }
}
