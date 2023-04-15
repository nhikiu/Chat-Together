import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../services/firebase_service.dart';
import '../../../utils/dialogs.dart';
import '../../../models/chat_user.dart';
import './logout_button.dart';
import './user_avatar.dart';

class ProfileBody extends StatelessWidget {
  ProfileBody({
    super.key,
    required this.chatuser,
  });

  final ChatUser chatuser;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Size sizeMediaQuery = MediaQuery.of(context).size;
    late String username;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Profile'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
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
                TextFormField(
                  initialValue: chatuser.username,
                  onSaved: (newValue) {
                    username = newValue ?? '';
                  },
                  validator: (username) {
                    if (username == null ||
                        username.isEmpty ||
                        username.length < 8 ||
                        username.length > 20) {
                      return 'Username must be between 8 - 20 characters';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      prefixIcon: const Icon(CupertinoIcons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      )),
                ),
                SizedBox(
                  height: sizeMediaQuery.height * 0.01,
                ),
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        minimumSize: const Size(60, 40)),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        FirebaseService.updateUser(username);
                        log('PROFILE SCREEN: VALIDATOR USERNAME');
                        FocusScope.of(context).unfocus();
                        Dialogs.showSnackBar(
                            context, 'Profile Update Successfully');
                      }
                    },
                    icon: const Icon(CupertinoIcons.pencil),
                    label: const Text('Update')),
                SizedBox(
                  height: sizeMediaQuery.height * 0.2,
                ),
                const LogOutButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
