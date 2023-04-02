import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

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
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    FirebaseFirestore.instance.collection('chat').add(
      {
        'text': _messageController.text,
        'createAt': Timestamp.now(),
        'userId': user!.uid,
        'username': userData['username'],
      },
    );
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
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
