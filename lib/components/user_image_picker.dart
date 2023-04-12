import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../helper/dialogs.dart';

class UserImagePicker extends StatefulWidget {
  final void Function(File imagedPicker) imagePickerFucntion;

  const UserImagePicker({super.key, required this.imagePickerFucntion});

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImage;

  @override
  Widget build(BuildContext context) {
    final Size sizeMediaQuery = MediaQuery.of(context).size;

    Future _pickImage() async {
      try {
        final picker = ImagePicker();
        final pickedImage = await picker.pickImage(
          source: ImageSource.gallery,
          //gioi han dung luong anh
          imageQuality: 90,
          maxWidth: 200,
        );
        final pickedImageFile = File(pickedImage!.path);

        setState(() {
          _pickedImage = pickedImageFile;
          widget.imagePickerFucntion(_pickedImage!);
        });
        log('Pick Image: $_pickedImage');
      } catch (e) {
        log('Picker Image Error: $e');
        Dialogs.showSnackBar(context, 'Something wrong with your image');
        return null;
      }
    }

    return Column(
      children: [
        CircleAvatar(
            radius: sizeMediaQuery.width * 0.2,
            backgroundColor: Theme.of(context).colorScheme.secondary,
            backgroundImage: (_pickedImage != null)
                ? FileImage(_pickedImage!) as ImageProvider
                : null),
        SizedBox(
          width: sizeMediaQuery.width * 0.4,
          child: TextButton(
              onPressed: _pickImage,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.image),
                  Text('Add Image'),
                ],
              )),
        ),
      ],
    );
  }
}
