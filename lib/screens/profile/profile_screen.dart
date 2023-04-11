import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../api/apis.dart';
import './components/profile_body.dart';
import '../../models/chat_user.dart';
import '../../screens/auth/auth_screen.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile';
  const ProfileScreen({super.key, required this.chatuser});

  final ChatUser chatuser;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: APIs.auth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ProfileBody(
              chatuser: widget.chatuser,
            );
          }
          return AuthScreen();
        });
  }
}
