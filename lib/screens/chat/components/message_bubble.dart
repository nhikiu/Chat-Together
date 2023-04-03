import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,
    required this.text,
    required this.isMe,
    required this.id,
    required this.username,
    required this.image,
  });

  final String username;
  final String text;
  final bool isMe;
  final Key id;
  final String image;

  Widget UserAvatar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: CircleAvatar(
        backgroundImage: NetworkImage(image),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!isMe) UserAvatar(),
        Container(
          decoration: BoxDecoration(
            color: isMe
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
              bottomLeft: isMe ? Radius.circular(10) : Radius.circular(0),
              bottomRight: isMe ? Radius.circular(0) : Radius.circular(10),
            ),
          ),
          width: MediaQuery.of(context).size.width * 0.5,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          margin: EdgeInsets.symmetric(horizontal: isMe ? 10 : 5, vertical: 5),
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                username,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isMe
                        ? Theme.of(context).colorScheme.secondary
                        : Theme.of(context).colorScheme.primary),
              ),
              Text(
                text,
                style: TextStyle(
                    color: isMe
                        ? Theme.of(context).colorScheme.secondary
                        : Theme.of(context).colorScheme.primary),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
