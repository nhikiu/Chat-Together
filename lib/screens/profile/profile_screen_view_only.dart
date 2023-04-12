import 'package:flutter/material.dart';

import './components/profile_body.dart';
import '../../models/chat_user.dart';
import 'components/user_avatar.dart';

class ProfileScreenViewOnly extends StatelessWidget {
  static const routeName = '/profile';
  const ProfileScreenViewOnly({super.key, required this.chatuser});

  final ChatUser chatuser;

  @override
  Widget build(BuildContext context) {
    final Size sizeMediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(chatuser.username),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
            ),
            UserAvatar(
              chatuser: chatuser,
            ),
            SizedBox(
              height: sizeMediaQuery.height * 0.03,
            ),
            Text(
              chatuser.email,
              style: const TextStyle(color: Colors.black54, fontSize: 20),
            ),
            SizedBox(
              height: sizeMediaQuery.height * 0.03,
            ),
            Text(
              'Username: ${chatuser.username}',
              style: const TextStyle(color: Colors.black, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
