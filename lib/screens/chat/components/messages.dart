import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../services/apis.dart';
import '../../../utils/date_util.dart';
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
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return StreamBuilder(
          stream: APIs.getAllMessages(chatUser),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            final data = snapshot.data?.docs;

            _messages =
                data?.map((e) => Message.fromJson(e.data())).toList() ?? [];

            return _messages.isEmpty
                ? const Center(child: Text('Start chat'))
                : ListView.builder(
                    reverse: true,
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      String dateOfMessage = DateUtil.getDateMessage(
                          context: context, time: _messages[index].createAt);

                      return Column(
                        children: [
                          if (dateOfMessage.isNotEmpty) Text(dateOfMessage),
                          MessageBubble(
                            message: _messages[index],
                          ),
                        ],
                      );
                    },
                  );
          },
        );
      },
    );
  }
}
