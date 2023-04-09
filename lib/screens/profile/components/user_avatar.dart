import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../helper/dialogs.dart';
import '../../../models/chat_user.dart';

class UserAvatar extends StatefulWidget {
  final ChatUser chatuser;
  const UserAvatar({
    super.key,
    required this.chatuser,
  });

  @override
  State<UserAvatar> createState() => _UserAvatarState();
}

class _UserAvatarState extends State<UserAvatar> {
  String? _imageFile;

  @override
  Widget build(BuildContext context) {
    final Size sizeMediaQuery = MediaQuery.of(context).size;
    return Stack(
      children: [
        _imageFile != null
            ? CircleAvatar(
                radius: sizeMediaQuery.width * 0.2,
                backgroundColor: Theme.of(context).colorScheme.secondary,
                backgroundImage: widget.chatuser.imageUrl.isEmpty
                    ? null
                    : FileImage(File(_imageFile!)),
              )
            : CircleAvatar(
                radius: sizeMediaQuery.width * 0.2,
                backgroundColor: Theme.of(context).colorScheme.secondary,
                backgroundImage: widget.chatuser.imageUrl.isEmpty
                    ? null
                    : NetworkImage(widget.chatuser.imageUrl),
              ),
        Positioned(
          right: 0,
          bottom: 0,
          child: MaterialButton(
            color: Colors.white.withOpacity(0.7),
            shape: CircleBorder(),
            onPressed: () async {
              try {
                final ImagePicker _picker = ImagePicker();
                // Pick an image.
                final XFile? _image =
                    await _picker.pickImage(source: ImageSource.gallery);

                if (_image != null) {
                  setState(() {
                    _imageFile = _image.path;
                  });
                  log('Image path: ${_imageFile}');
                }
              } catch (e) {
                Dialogs.showSnackBar(
                    context, 'Something wrong with your image');
              }
              //Navigator.pop(context);
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
