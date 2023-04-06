import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../api/apis.dart';
import './message_bubble.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.value(FirebaseAuth.instance.currentUser),
      builder: (ctx, futureSnapshot) {
        if (futureSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return StreamBuilder(
          stream: APIs.firestore
              .collection('chat')
              .orderBy('createAt', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            return ListView.builder(
              reverse: true,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return MessageBubble(
                    username: snapshot.data!.docs[index]['username'],
                    text: snapshot.data!.docs[index]['text'],
                    isMe: snapshot.data!.docs[index]['userId'] ==
                        futureSnapshot.data!.uid,
                    image: snapshot.data!.docs[index]['userimage'],
                    id: ValueKey(
                      snapshot.data!.docs[index].id,
                    ));
              },
            );
          },
        );
      },
    );
  }
}
