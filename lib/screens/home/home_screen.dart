import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../api/apis.dart';
import './components/chat_user_card.dart';
import '../../screens/profile/profile_screen.dart';
import '../../models/chat_user.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ChatUser> chatusers = [];

  @override
  void initState() {
    super.initState();
    APIs.getSelfInfor();
  }

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
                        Icon(CupertinoIcons.person),
                        Text('Your profile')
                      ]),
                  value: 'profile-detail',
                ),
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
                log("IDENTIFIER: ${identifier}");
                if (identifier == 'logout') {
                  APIs.auth.signOut();
                } else if (identifier == 'profile-detail') {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => ProfileScreen(chatuser: APIs.me)));
                  // Navigator.of(context).pushNamed(ProfileScreen.routeName, arguments: {'chatuser': APIs.me});
                }
              },
            ),
          ],
        ),
        body: StreamBuilder(
          stream: APIs.getAllUsers(),
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
                        },
                      );
            }
          },
        ));
  }
}
