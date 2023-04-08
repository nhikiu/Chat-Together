import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
            onPressed: () {},
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
