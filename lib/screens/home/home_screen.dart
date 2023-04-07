import 'dart:convert';
import 'dart:developer';

import 'package:chat_together/models/chat_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../api/apis.dart';
import '../../helper/dialogs.dart';
import 'components/chat_user_card.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';
  HomeScreen({super.key});

  List<ChatUser> chatusers = [];

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
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.none:
                return Center(
                  child: CircularProgressIndicator(),
                );
              case ConnectionState.active:
              case ConnectionState.done:
                if (snapshot.hasData) {
                  final data = snapshot.data?.docs;
                  chatusers =
                      data!.map((e) => ChatUser.fromJson(e.data())).toList() ??
                          [];
                  for (var i in chatusers) {
                    log("DATA: ${i.toJson()}");
                  }
                }

                return chatusers.isEmpty
                    ? Center(
                        child: Text('No connection found'),
                      )
                    : ListView.builder(
                        itemCount: chatusers.length,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (ctx, index) {
                          return InkWell(
                            onTap: () {},
                            child: ChatUserCard(
                              chatUser: chatusers[index],
                            ),
                          );
                        });
            }
          },
        ));
  }
}
