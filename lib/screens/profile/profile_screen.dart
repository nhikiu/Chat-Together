import 'package:chat_together/models/chat_user.dart';
import 'package:chat_together/screens/auth/auth_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../api/apis.dart';
import '../../helper/dialogs.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = '/profile';
  ProfileScreen({super.key, required this.chatuser});

  final ChatUser chatuser;

  @override
  Widget build(BuildContext context) {
    final Size sizeMediaQuery = MediaQuery.of(context).size;
    return StreamBuilder(
        stream: APIs.auth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Chat'),
              ),
              body: Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                    ),
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: sizeMediaQuery.width * 0.2,
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
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
                    ),
                    SizedBox(
                      height: sizeMediaQuery.height * 0.03,
                    ),
                    Text(
                      chatuser.email,
                      style: TextStyle(color: Colors.black54, fontSize: 20),
                    ),
                    SizedBox(
                      height: sizeMediaQuery.height * 0.03,
                    ),
                    TextFormField(
                      initialValue: chatuser.username,
                      decoration: InputDecoration(
                          prefixIcon: Icon(CupertinoIcons.person),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          )),
                    ),
                    SizedBox(
                      height: sizeMediaQuery.height * 0.01,
                    ),
                    ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            shape: StadiumBorder(), minimumSize: Size(60, 40)),
                        onPressed: () {},
                        icon: Icon(CupertinoIcons.pencil),
                        label: Text('Update')),
                    SizedBox(
                      height: sizeMediaQuery.height * 0.2,
                    ),
                    TextButton(
                        onPressed: () async {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Do you want log sign out ?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'Cancel',
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .error),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      Dialogs.showProgressBar(context);
                                      await APIs.auth.signOut().then((value) {
                                        //hiden dialog
                                        Navigator.pop(context);
                                        //hiden profile screen
                                        Navigator.pop(context);
                                      });
                                    },
                                    child: Text(
                                      'Confirm',
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                          //await APIs.auth.signOut();
                          //Navigator.popAndPushNamed(context, AuthScreen.routeName);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              CupertinoIcons.square_arrow_right,
                              color: Theme.of(context).colorScheme.error,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Log out',
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.error),
                            )
                          ],
                        )),
                  ],
                ),
              ),
            );
          }
          return AuthScreen();
        });
  }
}
