import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../services/firebase_service.dart';
import '../../../utils/dialogs.dart';
import '../../../models/chat_user.dart';
import '../../../services/notification_services.dart';
import '../../../models/message.dart';

class NewMessage extends StatefulWidget {
  const NewMessage(
      {super.key, required this.chatUser, required this.notificationServices});
  final ChatUser chatUser;
  final NotificationServices notificationServices;
  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final TextEditingController _messageController = TextEditingController();
  var message;

  void _sendNotification() {
    widget.notificationServices.getDeviceToken().then((value) async {
      print('token in other');
      print(widget.chatUser.pushToken);

      var data = {
        'to': widget.chatUser.pushToken,
        'priority': 'high',
        'notification': {
          'title': widget.chatUser.username,
          'body': message,
        },
        'data': {
          'type': 'New message',
          'id': '${widget.chatUser.id}',
        }
      };
      await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          body: jsonEncode(data),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization':
                'key=AAAAYfadbMQ:APA91bGMZCPeOxkzye7nsvnblrI0vpTkL1bhQ91THgdXsbI3C4f0n62onEY5fo06xFq0Ng2KL75uiJkrAmIkvWJXCrBLKuz33HIbY-2jnzYg635u5K960b46Nlfp_JyNLDjxIJxAY8JH',
          });
    });
  }

  void _sendMessage() async {
    //auto close keyboard
    FocusScope.of(context).unfocus();
    message = _messageController.text;
    await FirebaseService.sendMessage(
        widget.chatUser, _messageController.text, Type.text);
    _sendNotification();
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
                  await FirebaseService.sendImage(
                      chatUser: widget.chatUser, image: image!.path);
                  message = 'Sent a picture';
                  // _sendMessage();
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
