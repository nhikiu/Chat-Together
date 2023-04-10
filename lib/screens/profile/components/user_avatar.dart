import 'package:flutter/material.dart';
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
    return CircleAvatar(
      radius: sizeMediaQuery.width * 0.2,
      backgroundColor: Theme.of(context).colorScheme.secondary,
      backgroundImage: widget.chatuser.imageUrl.isEmpty
          ? null
          : NetworkImage(widget.chatuser.imageUrl),
    );
  }
}
