import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../api/apis.dart';
import './components/messages.dart';
import './components/new_message.dart';

class ChatScreen extends StatelessWidget {
  static const routeName = '/chat';

  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
        leading: Icon(CupertinoIcons.home),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.search)),
          DropdownButton(
            items: [
              DropdownMenuItem(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(CupertinoIcons.square_arrow_right),
                      Text('Logout')
                    ]),
                value: 'logout',
              )
            ],
            icon: Icon(CupertinoIcons.ellipsis_vertical),
            onChanged: (identifier) {
              if (identifier == 'logout') {
                APIs.auth.signOut();
              }
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Expanded(child: Messages()), NewMessage()],
      ),
    );
  }
}
