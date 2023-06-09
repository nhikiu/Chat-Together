import 'package:flutter/material.dart';

import '../../services/firebase_service.dart';
import './components/profile_body.dart';
import '../../models/chat_user.dart';
import '../../screens/auth/auth_screen.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = '/profile';
  const ProfileScreen({super.key, required this.chatuser});

  final ChatUser chatuser;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseService.auth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            return ProfileBody(
              chatuser: chatuser,
            );
          }
          return AuthScreen();
        });
  }
}
