import 'package:flutter/material.dart';

import '../../../models/chat_user.dart';

class UserAvatar extends StatelessWidget {
  final ChatUser chatuser;
  UserAvatar({
    super.key,
    required this.chatuser,
  });

  String? _imageFile;

  @override
  Widget build(BuildContext context) {
    final Size sizeMediaQuery = MediaQuery.of(context).size;
    return CircleAvatar(
      radius: sizeMediaQuery.width * 0.2,
      backgroundColor: Theme.of(context).colorScheme.secondary,
      backgroundImage:
          chatuser.imageUrl.isEmpty ? null : NetworkImage(chatuser.imageUrl),
    );
  }
}
