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
        body: ListView.builder(
            itemCount: 20,
            physics: BouncingScrollPhysics(),
            itemBuilder: (ctx, index) {
              return InkWell(
                onTap: () {},
                child: ChatUserCard(),
              );
            }));
  }
}
