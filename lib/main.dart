import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './firebase_options.dart';
import './constants.dart';
import './screens/auth/auth_screen.dart';
import './screens/welcome/welcome_screen.dart';
import 'services/firebase_service.dart';
import './screens/home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
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
        appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
            backgroundColor: Colors.white,
            elevation: 1,
            centerTitle: true,
            iconTheme: IconThemeData(color: Colors.black)),
      ),
      home: StreamBuilder(
        stream: FirebaseService.auth.authStateChanges(),
        builder: (context, snapshot) {
          //if use has data in database
          if (snapshot.hasData) {
            return HomeScreen();
          }
          //user haven't account
          return AuthScreen();
        },
      ),
      routes: {
        WelcomeScreen.routeName: (context) => WelcomeScreen(),
        AuthScreen.routeName: (context) => AuthScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
      },
    );
  }
}
