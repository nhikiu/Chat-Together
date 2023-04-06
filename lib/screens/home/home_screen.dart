import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../api/apis.dart';
import 'components/chat_user_card.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Chat'),
          leading: Icon(CupertinoIcons.home),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.search)),
            DropdownButton(
              items: [
                DropdownMenuItem(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(CupertinoIcons.square_arrow_right),
                        Text('Logout')
                      ]),
                  value: 'logout',
                )
              ],
              icon: Icon(CupertinoIcons.ellipsis_vertical),
              onChanged: (identifier) {
                if (identifier == 'logout') {
                  APIs.auth.signOut();
                }
              },
            ),
          ],
        ),
        body: StreamBuilder(
          stream: APIs.firestore.collection('users').snapshots(),
          builder: (context, snapshot) {
            final users = [];

            if (snapshot.hasData) {
              final data = snapshot.data?.docs;
              for (var i in data!) {
                log('Data: ${jsonEncode(i.data())}');
                users.add(i.data()['username']);
              }
            }

            return ListView.builder(
                itemCount: users.length,
                physics: BouncingScrollPhysics(),
                itemBuilder: (ctx, index) {
                  return Text(users[index]);
                  // InkWell(
                  //   onTap: () {},
                  //   child: ChatUserCard(),
                  // );
                });
          },
        ));
  }
}
