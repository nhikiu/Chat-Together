import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../helper/dialogs.dart';
import '../../../models/chat_user.dart';

class UserAvatar extends StatelessWidget {
  final ChatUser chatuser;
  const UserAvatar({
    super.key,
    required this.chatuser,
  });

  @override
  Widget build(BuildContext context) {
    final Size sizeMediaQuery = MediaQuery.of(context).size;

    Widget ImageButton(String image) {
      return ElevatedButton(
        onPressed: () async {
          try {
            final ImagePicker _picker = ImagePicker();
            // Pick an image.
            final XFile? _image =
                await _picker.pickImage(source: ImageSource.gallery);

            if (_image != null) {
              log('Image path: ${_image.path} and Mime Type: ${_image.mimeType}');
            }
          } catch (e) {
            Dialogs.showSnackBar(context, 'Something wrong with your image');
          }
          Navigator.pop(context);
        },
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          backgroundColor: Colors.white,
          fixedSize:
              Size(sizeMediaQuery.width * 0.2, sizeMediaQuery.width * 0.2),
        ),
        child: Image.asset(image),
      );
    }

    void _showModelBottom() {
      showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        builder: (_) {
          return Container(
            child: ListView(
              shrinkWrap: true,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Pick your avatar',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ImageButton('assets/images/add-image.png'),
                    ImageButton('assets/images/camera.png'),
                  ],
                )
              ],
            ),
          );
        },
      );
    }

    return Stack(
      children: [
        CircleAvatar(
          radius: sizeMediaQuery.width * 0.2,
          backgroundColor: Theme.of(context).colorScheme.secondary,
          backgroundImage: chatuser.imageUrl.isEmpty
              ? null
              : NetworkImage(chatuser.imageUrl),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: MaterialButton(
            color: Colors.white.withOpacity(0.7),
            shape: CircleBorder(),
            onPressed: () {
              _showModelBottom();
            },
            child: Icon(
              CupertinoIcons.pencil,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        )
      ],
    );
  }
}
