import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatUserCard extends StatelessWidget {
  const ChatUserCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(CupertinoIcons.person),
        ),
        title: Text(
          'Demo username',
          maxLines: 1,
        ),
        subtitle: Text(
          'Last user message',
          maxLines: 1,
        ),
        trailing: Text(
          '12:00 PM',
          style: TextStyle(color: Colors.black54),
        ),
      ),
    );
  }
}
