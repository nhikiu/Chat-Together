import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../models/chat_user.dart';

class ChatUserCard extends StatelessWidget {
  final ChatUser chatUser;

  const ChatUserCard({
    super.key,
    required this.chatUser,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          backgroundImage: chatUser.imageUrl.isEmpty
              ? null
              : NetworkImage(chatUser.imageUrl),
        ),
        title: Text(
          chatUser.username,
          maxLines: 1,
        ),
        subtitle: Text(
          'Last user message',
          maxLines: 1,
        ),
        trailing: chatUser.isOnline
            ? Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10)),
              )
            : Text(
                '12:00 PM',
                style: TextStyle(color: Colors.black54),
              ),
      ),
    );
  }
}
