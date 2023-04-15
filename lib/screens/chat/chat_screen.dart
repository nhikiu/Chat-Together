import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/chat_user.dart';
import './components/messages.dart';
import './components/new_message.dart';
import '../profile/profile_screen_view_only.dart';
import '../../services/notification_services.dart';

class ChatScreen extends StatelessWidget {
  static const routeName = '/chat';

  const ChatScreen(
      {super.key, required this.chatuser, required this.notificationServices});

  final ChatUser chatuser;
  final NotificationServices notificationServices;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        ProfileScreenViewOnly(chatuser: chatuser)));
              },
              icon: Icon(
                CupertinoIcons.info,
                color: Theme.of(context).colorScheme.primary,
              ))
        ],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Theme.of(context).colorScheme.secondary,
              backgroundImage: chatuser.imageUrl.isEmpty
                  ? null
                  : NetworkImage(chatuser.imageUrl),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  chatuser.username,
                  maxLines: 1,
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                      fontWeight: FontWeight.w500),
                ),
              ],
            )
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Messages(
            chatUser: chatuser,
          )),
          NewMessage(
            chatUser: chatuser,
            notificationServices: notificationServices,
          )
        ],
      ),
    );
  }
}
