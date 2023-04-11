import 'package:flutter/material.dart';

import '../../../models/message.dart';
import '../../../api/apis.dart';
import '../../../helper/date_util.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble({
    super.key,
    required this.message,
  });
  final Message message;

  Widget UserAvatar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: CircleAvatar(
        backgroundImage: NetworkImage(message.userimage),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isMe = (APIs.user.uid == message.fromid);
    print('${isMe}');

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    message.username,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isMe
                            ? Theme.of(context).colorScheme.secondary
                            : Theme.of(context).colorScheme.primary),
                  ),
                  Text(
                    DateUtil.getFormattedTime(
                        context: context, time: message.createAt),
                    style: TextStyle(
                        fontSize: 12,
                        color: isMe ? Colors.white70 : Colors.black54),
                  )
                ],
              ),
              Text(
                message.text,
                textAlign: TextAlign.start,
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
