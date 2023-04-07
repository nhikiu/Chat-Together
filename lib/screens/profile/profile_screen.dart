import 'package:chat_together/models/chat_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = '/profile';
  ProfileScreen({super.key, required this.chatuser});

  final ChatUser chatuser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Chat'),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
              ),
              CircleAvatar(
                radius: MediaQuery.of(context).size.width * 0.2,
                backgroundColor: Theme.of(context).colorScheme.secondary,
                backgroundImage: chatuser.imageUrl.isEmpty
                    ? null
                    : NetworkImage(chatuser.imageUrl),
              ),
              Text(chatuser.email),
              TextFormField(
                initialValue: chatuser.username,
              ),
              TextButton(
                  onPressed: () {},
                  child: Row(
                    children: [Icon(CupertinoIcons.escape), Text('Log out')],
                  )),
            ],
          ),
        ));
  }
}
