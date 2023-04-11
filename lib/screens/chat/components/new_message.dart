import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../api/apis.dart';
import '../../../constants.dart';
import '../../../models/chat_user.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key, required this.chatUser});
  final ChatUser chatUser;
  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  TextEditingController _messageController = TextEditingController();
  var _enteredMessage = '';

  void _sendMessage() async {
    //auto close keyboard
    FocusScope.of(context).unfocus();

    final user = await FirebaseAuth.instance.currentUser;
    final userData = await APIs.firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    await APIs.sendMessage(widget.chatUser, _messageController.text);

    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                CupertinoIcons.photo,
                color: Theme.of(context).colorScheme.primary,
              )),
          Expanded(
            child: TextField(
              controller: _messageController,
              maxLines: null,
              decoration: InputDecoration(
                hintText: 'Send a message',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
                contentPadding: EdgeInsets.all(10),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
          IconButton(
              onPressed:
                  _messageController.text.trim().isEmpty ? null : _sendMessage,
              icon: Icon(
                Icons.send,
                color: kPrimaryColor,
              ))
        ],
      ),
    );
  }
}
