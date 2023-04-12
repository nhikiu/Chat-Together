import 'dart:developer';

import 'package:chat_together/models/message.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../api/apis.dart';
import '../../../helper/dialogs.dart';
import '../../../models/chat_user.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key, required this.chatUser});
  final ChatUser chatUser;
  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final TextEditingController _messageController = TextEditingController();

  void _sendMessage() async {
    //auto close keyboard
    FocusScope.of(context).unfocus();
    await APIs.sendMessage(widget.chatUser, _messageController.text, Type.text);
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          IconButton(
              onPressed: () async {
                try {
                  final ImagePicker picker = ImagePicker();
                  final XFile? image = await picker.pickImage(
                      source: ImageSource.gallery, imageQuality: 70);
                  await APIs.sendImage(
                      chatUser: widget.chatUser, image: image!.path);
                  log('Pick Image: ${image.path}');
                } catch (e) {
                  log('Picker Image Error: ${e}');
                  Dialogs.showSnackBar(
                      context, 'Something wrong with your image');
                }
              },
              icon: Icon(
                Icons.photo,
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
                contentPadding: const EdgeInsets.all(10),
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
                color: Theme.of(context).colorScheme.primary,
              ))
        ],
      ),
    );
  }
}
