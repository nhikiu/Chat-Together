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
          //leading: Icon(CupertinoIcons.home),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.search)),
          ],
        ),
        drawer: Drawer(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => ProfileScreen(chatuser: APIs.me)));
                  },
                  icon: Icon(CupertinoIcons.person),
                  label: Text('Your profile')),
              TextButton.icon(
                  onPressed: () {
                    APIs.auth.signOut();
                  },
                  icon: Icon(CupertinoIcons.square_arrow_right),
                  label: Text('Logout'))
            ],
          )),
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
