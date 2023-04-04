import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
      log('Pick Image: ${_pickedImage}');
    }

    return Column(
      children: [
        CircleAvatar(
            radius: sizeMediaQuery.width * 0.2,
            backgroundColor: Theme.of(context).colorScheme.secondary,
            backgroundImage: (_pickedImage != null)
                ? FileImage(_pickedImage!) as ImageProvider
                : null),
        Container(
          width: sizeMediaQuery.width * 0.4,
          child: TextButton(
              onPressed: _pickImage,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.image),
                  const Text('Add Image'),
                ],
              )),
        ),
      ],
    );
  }
}
