import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../api/apis.dart';
import './message_bubble.dart';
import '../../../models/chat_user.dart';
import '../../../models/message.dart';

class Messages extends StatelessWidget {
  Messages({super.key, required this.chatUser});

  final ChatUser chatUser;

  List<Message> _messages = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.value(FirebaseAuth.instance.currentUser),
      builder: (ctx, futureSnapshot) {
        if (futureSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return StreamBuilder(
          stream: APIs.getAllMessages(chatUser),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            final data = snapshot.data?.docs;
            log('DATA MESSAGE at 0: ${jsonEncode(data?[0].data())}');

            _messages =
                data?.map((e) => Message.fromJson(e.data())).toList() ?? [];
            return _messages.length == 0
                ? Center(child: Text('Start chat'))
                : ListView.builder(
                    reverse: true,
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      return MessageBubble(
                        message: _messages[index],
                      );
                    },
                  );
          },
        );
      },
    );
  }
}
