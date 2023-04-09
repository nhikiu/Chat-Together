import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../api/apis.dart';
import '../../../helper/dialogs.dart';
import '../../../models/chat_user.dart';
import './logout_button.dart';
import './user_avatar.dart';

class ProfileBody extends StatefulWidget {
  ProfileBody({
    super.key,
    required this.chatuser,
  });

  final ChatUser chatuser;
  

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Size sizeMediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Profile'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                ),
                UserAvatar(
                  chatuser: widget.chatuser,
                ),
                SizedBox(
                  height: sizeMediaQuery.height * 0.03,
                ),
                Text(
                  widget.chatuser.email,
                  style: TextStyle(color: Colors.black54, fontSize: 20),
                ),
                SizedBox(
                  height: sizeMediaQuery.height * 0.03,
                ),
                TextFormField(
                  initialValue: widget.chatuser.username,
                  onSaved: (newValue) {
                    APIs.me.username = newValue ?? '';
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
                      prefixIcon: Icon(CupertinoIcons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      )),
                ),
                SizedBox(
                  height: sizeMediaQuery.height * 0.01,
                ),
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(), minimumSize: Size(60, 40)),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        APIs.updateUser();
                        log('PROFILE SCREEN: VALIDATOR USERNAME');
                        FocusScope.of(context).unfocus();
                        Dialogs.showSnackBar(
                            context, 'Profile Update Successfully');
                      }
                    },
                    icon: Icon(CupertinoIcons.pencil),
                    label: Text('Update')),
                SizedBox(
                  height: sizeMediaQuery.height * 0.2,
                ),
                LogOutButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
