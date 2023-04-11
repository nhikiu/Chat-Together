import 'package:flutter/material.dart';

import '../../../models/chat_user.dart';
import '../../../api/apis.dart';
import '../../../helper/date_util.dart';
import '../../../models/message.dart';

class ChatUserCard extends StatelessWidget {
  final ChatUser chatUser;

  const ChatUserCard({
    super.key,
    required this.chatUser,
  });

  @override
  Widget build(BuildContext context) {
    Message? _lastMessage;

    return StreamBuilder(
        stream: APIs.getLastMessage(chatUser),
        builder: (context, snapshot) {
          final data = snapshot.data?.docs;
          if (data != null && data.first.exists) {
            _lastMessage = Message.fromJson(data.first.data());
          }

          return Card(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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
                _lastMessage != null
                    ? (APIs.user.uid == _lastMessage!.fromid
                            ? 'You: '
                            : '${chatUser.username}: ') +
                        (_lastMessage!.text.length < 15
                            ? '${_lastMessage!.text}'
                            : '')
                    : '',
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
                      _lastMessage != null
                          ? DateUtil.getLastMessageTime(
                              context: context, time: _lastMessage!.createAt)
                          : '',
                      style: TextStyle(color: Colors.black54),
                    ),
            ),
          );
        });
  }
}
