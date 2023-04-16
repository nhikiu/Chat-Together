import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../services/notification_services.dart';
import '../../services/firebase_service.dart';
import './components/chat_user_card.dart';
import '../../screens/profile/profile_screen.dart';
import '../../models/chat_user.dart';
import '../chat/chat_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ChatUser> _chatusers = [];
  List<ChatUser> _chatusersSearch = [];
  bool _isSearching = false;
  static NotificationServices notificationServices = NotificationServices();
  late ChatUser currentUser;

  @override
  void initState() {
    super.initState();
    notificationServices.requestNotificationPermission();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
  }

  @override
  Widget build(BuildContext context) {
    Widget searchField = Container(
      margin: EdgeInsets.symmetric(vertical: 50),
      child: TextField(
        decoration: const InputDecoration(
            border: InputBorder.none, hintText: 'Username, Email,...'),
        autofocus: true,
        onChanged: (value) {
          _chatusersSearch.clear();
          for (var i in _chatusers) {
            if (i.email.toLowerCase().contains(value.toLowerCase().trim()) ||
                i.username.toLowerCase().contains(value.trim())) {
              _chatusersSearch.add(i);
            }
          }
          setState(() {
            _chatusersSearch;
          });
        },
      ),
    );

    Widget drawer = Drawer(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton.icon(
              onPressed: () async {
                Navigator.of(context).pop();
                final userDoc = await FirebaseService.firestore
                    .collection('users')
                    .doc(FirebaseService.auth.currentUser!.uid)
                    .get();
                if (userDoc.exists) {
                  currentUser = ChatUser.fromJson(userDoc.data()!);
                  log('CurrentUser is exist: ${currentUser.toJson()}');
                } else {
                  log('CurrentUser dont exist');
                }
                notificationServices.getDeviceToken().then((token) async {
                  log('HomePage: <device token> $token');
                  FirebaseService.updateToken(token);
                });
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => ProfileScreen(chatuser: currentUser)));
              },
              icon: const Icon(CupertinoIcons.person),
              label: const Text('Your profile')),
          TextButton.icon(
              onPressed: () {
                FirebaseService.auth.signOut();
              },
              icon: const Icon(CupertinoIcons.square_arrow_right),
              label: const Text('Logout'))
        ],
      )),
    );

    return Scaffold(
      appBar: AppBar(
        title: _isSearching ? searchField : const Text('Chat Together'),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  _isSearching = !_isSearching;
                  _chatusersSearch.clear();
                });
              },
              icon: Icon(
                  _isSearching ? CupertinoIcons.home : CupertinoIcons.search)),
        ],
      ),
      drawer: drawer,
      body: StreamBuilder(
        stream: FirebaseService.getAllUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            final data = snapshot.data?.docs;
            _chatusers = data!.map((e) => ChatUser.fromJson(e.data())).toList();
            _chatusers.sort((a, b) => a.username.compareTo(b.username));

            log('ChatUserListLength: ${_chatusers.length}');
          }

          return _chatusers.isEmpty
              ? const Center(
                  child: Text('No connection found'),
                )
              : ListView.builder(
                  itemCount: _isSearching
                      ? _chatusersSearch.length
                      : _chatusers.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (ctx, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => ChatScreen(
                              notificationServices: notificationServices,
                              chatuser: _isSearching
                                  ? _chatusersSearch[index]
                                  : _chatusers[index],
                            ),
                          ),
                        );
                      },
                      child: ChatUserCard(
                        chatUser: _isSearching
                            ? _chatusersSearch[index]
                            : _chatusers[index],
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
