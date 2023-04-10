import 'dart:io';

import 'package:chat_together/models/chat_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../api/apis.dart';
import '../../helper/dialogs.dart';
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
      File? image, bool isLogin, BuildContext ctx) async {
    UserCredential _userCredential;
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        _userCredential = await APIs.auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        _userCredential = await APIs.auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        final ref = APIs.storage
            .ref()
            .child('user_image')
            .child('${_userCredential.user!.uid}.jpg');
        await ref.putFile(image!).whenComplete(() => null);

        final urlImage = await ref.getDownloadURL();

        await APIs.firestore
            .collection('users')
            .doc(_userCredential.user!.uid)
            .set({
          'id': _userCredential.user!.uid,
          'email': email,
          'username': username,
          'image_url': urlImage,
          'is_online': true,
          'last_active': '',
          'push_token': ''
        });
        await APIs.firestore
            .collection('users')
            .doc(APIs.auth.currentUser!.uid)
            .get()
            .then((value) {
          APIs.me = ChatUser.fromJson(value.data()!);
        });
      }
    } on PlatformException catch (e) {
      String message = 'An error occurred, please check your credential';

      if (e.message != null) {
        message = e.message!;
      }
      print(e.message);
      Dialogs.showSnackBar(ctx, message);
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
      Dialogs.showSnackBar(ctx, message);
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print('SIGN IN ERROR ${e}');
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
