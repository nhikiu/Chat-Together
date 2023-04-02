import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'components/auth_body.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth';

  AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var _isLoading = false;

  void _submitAuthForm(String email, String username, String password,
      bool isLogin, BuildContext ctx) async {
    UserCredential _userCredential;
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        _userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        _userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        await FirebaseFirestore.instance
            .collection('users')
            .doc(_userCredential.user!.uid)
            .set({'email': email, 'username': username});
      }
      // setState(() {
      //   _isLoading = false;
      // });
    } on PlatformException catch (e) {
      String message = 'An error occurred, please check your credential';

      if (e.message != null) {
        message = e.message!;
      }
      print(e.message);
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ));
      setState(() {
        _isLoading = false;
      });
    } on FirebaseAuthException catch (err) {
      String message = 'An error occurred, please check your credential';

      if (err.code == 'user-not-found') {
        print('No user found for that email.');
        message = 'No user found for that email.';
      } else if (err.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        message = 'Wrong password provided for that user.';
      } else if (err.code == 'email-already-in-use') {
        print('The email address is already in use by another account.');
        message = 'The email address is already in use by another account.';
      }
      print(err);
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ));
      setState(() {
        _isLoading = false;
      });
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return AuthBody(
      submitUser: _submitAuthForm,
      isLoading: _isLoading,
      
    );
  }
}
