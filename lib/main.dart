import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './firebase_options.dart';
import './constants.dart';
import './screens/auth/auth_screen.dart';
import './screens/chat/chat_screen.dart';
import './screens/welcome/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat Together',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(primary: kPrimaryColor, secondary: kPrimaryLightColor),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
            titleTextStyle: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
            backgroundColor: Colors.white,
            elevation: 1,
            centerTitle: true,
            iconTheme: IconThemeData(color: Colors.black)),
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //if use has data in database
          if (snapshot.hasData) {
            return ChatScreen();
          }
          //user haven't account
          return AuthScreen();
        },
      ),
      routes: {
        WelcomeScreen.routeName: (context) => WelcomeScreen(),
        AuthScreen.routeName: (context) => AuthScreen(),
        ChatScreen.routeName: (context) => ChatScreen()
      },
    );
  }
}
