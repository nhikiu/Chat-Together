import 'package:flutter/material.dart';

import '../../../models/chat_user.dart';
import '../../../services/apis.dart';
import '../../../utils/date_util.dart';
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

    String _getSubtitle({required Message lastMessage}) {
      String text = '';
      //isMe == true (current user sent last message)
      if (APIs.user.uid == _lastMessage!.fromid) {
        text += 'You: ';
      } else {
        text += '${chatUser.username}: ';
      }
      if (_lastMessage!.type == Type.text) {
        if (_lastMessage!.text.length >= 15) {
          text += _lastMessage!.text.substring(0, 12);
          text += '...';
        } else {
          text += _lastMessage!.text;
        }
      } else {
        text += 'Sent a picture';
      }

      return text;
    }

    return StreamBuilder(
        stream: APIs.getLastMessage(chatUser),
        builder: (context, snapshot) {
          final data = snapshot.data?.docs;

          if (data != null && data.isNotEmpty && data.first.exists) {
            _lastMessage = Message.fromJson(data.first.data());
          }

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                    ? _getSubtitle(lastMessage: _lastMessage!)
                    : 'Send a message',
                maxLines: 1,
              ),
              trailing: Text(
                _lastMessage != null
                    ? DateUtil.getMessageTime(
                        context: context, time: _lastMessage!.createAt)
                    : '',
                style: const TextStyle(color: Colors.black54),
              ),
            ),
          );
        });
  }
}
