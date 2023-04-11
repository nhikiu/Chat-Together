import 'dart:developer';
import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../components/already_have_an_account.dart';
import '../../../components/rounded_button.dart';
import '../../../components/rounded_container.dart';
import '../../../components/rounded_password_field.dart';
import '../../../components/user_image_picker.dart';
import '../../../constants.dart';
import './auth_background.dart';
import '../../../helper/dialogs.dart';

class AuthBody extends StatefulWidget {
  const AuthBody({
    super.key,
    required this.submitUser,
    required this.isLoading,
  });
  final bool isLoading;
  final void Function(String email, String username, String password,
      File? image, bool isAuth, BuildContext context) submitUser;

  @override
  State<AuthBody> createState() => _AuthBodyState();
}

class _AuthBodyState extends State<AuthBody> {
  final _formKey = GlobalKey<FormState>();
  final _formResettKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  File? _userImageFile;

  var _isLogIn = true;

  void _pickImage(File pickedImage) {
    _userImageFile = pickedImage;
  }

  //enable validator
  void _trySubmit(BuildContext context) {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (_userImageFile == null && !_isLogIn) {
      Dialogs.showSnackBar(context, 'Please pick an image');
      return;
    }

    if (isValid) {
      _formKey.currentState!.save();

      widget.submitUser(
        _emailController.text.trim(),
        _usernameController.text.trim(),
        _passwordController.text.trim(),
        _userImageFile,
        _isLogIn,
        context,
      );
    }
  }

  FormFieldValidator _validateEmail() {
    return (value) {
      if (value == null || value.isEmpty || !EmailValidator.validate(value)) {
        return 'Please enter a valid email address.';
      }
      return null;
    };
  }

  FormFieldValidator _validatorUserName() {
    return (username) {
      if (username == null || username.isEmpty || username.length > 12) {
        return 'Username can be upto a maximum of 12 characters';
      }
      return null;
    };
  }

  FormFieldValidator _validatorPassword() {
    return (password) {
      if (password == null ||
          password.isEmpty ||
          password.length < 8 ||
          password.length > 20) {
        return 'Password must be between 8 - 20 characters';
      }
      return null;
    };
  }

  @override
  Widget build(BuildContext context) {
    final Size sizeMediaQuery = MediaQuery.of(context).size;

    Future<String?> _openDialogTextField({required String title}) {
      TextEditingController _emailResetController = TextEditingController();
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(title),
              content: Form(
                key: _formResettKey,
                child: TextFormField(
                  autofocus: true,
                  validator: _validateEmail(),
                  controller: _emailResetController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(hintText: 'Enter your email'),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    final isValid = _formResettKey.currentState!.validate();
                    if (isValid) {
                      final String _emailReset =
                          _emailResetController.text.trim();
                      Dialogs.showSnackBar(
                          context, 'Please check your email to reset password');

                      Navigator.of(context).pop();
                      log('Email enter to reset password: ${_emailReset}');
                      await FirebaseAuth.instance
                          .sendPasswordResetEmail(email: _emailReset);
                    }
                  },
                  child: Text('Confirm'),
                ),
              ],
            );
          });
    }

    return AuthBackground(
        centerBody: SafeArea(
      child: SingleChildScrollView(
        child: Container(
          height: sizeMediaQuery.height,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_isLogIn)
                SvgPicture.asset(
                  'assets/icons/chat.svg',
                  height: sizeMediaQuery.height * 0.4,
                ),
              if (_isLogIn)
                SizedBox(
                  height: sizeMediaQuery.height * 0.05,
                ),
              Text(
                _isLogIn ? 'LOG IN' : 'SIGN UP',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: sizeMediaQuery.height * 0.01,
              ),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (!_isLogIn)
                      UserImagePicker(
                        imagePickerFucntion: _pickImage,
                      ),
                    SizedBox(
                      height: 20,
                    ),
                    RoundedContainer(
                      child: TextFormField(
                        key: ValueKey('email'),
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: _validateEmail(),
                        decoration: InputDecoration(
                          hintText: 'Your email',
                          icon:
                              Icon(CupertinoIcons.person, color: kPrimaryColor),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    if (!_isLogIn)
                      RoundedContainer(
                        child: TextFormField(
                          key: ValueKey('username'),
                          controller: _usernameController,
                          validator: _validatorUserName(),
                          decoration: InputDecoration(
                            hintText: 'Username',
                            icon: Icon(CupertinoIcons.person,
                                color: kPrimaryColor),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    RoundedPasswordField(
                      key: ValueKey('password'),
                      onChanged: (value) {},
                      controller: _passwordController,
                      validator: _validatorPassword(),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: sizeMediaQuery.height * 0.01,
              ),
              if (_isLogIn)
                Container(
                  margin: EdgeInsets.only(right: sizeMediaQuery.width * 0.1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                          onTap: () async {
                            await _openDialogTextField(
                                title: 'Enter your email');
                          },
                          child: Text(
                            'Forgot password ?',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary),
                          )),
                    ],
                  ),
                ),
              if (widget.isLoading) CircularProgressIndicator(),
              if (!widget.isLoading)
                RoundedButton(
                    title: _isLogIn ? 'Log In' : 'Sign Up',
                    press: () {
                      _trySubmit(context);
                    },
                    backgroundColor: kPrimaryColor,
                    textColor: kPrimaryLightColor),
              if (!widget.isLoading)
                AlreadyAnAccountCheck(
                  login: _isLogIn,
                  press: () {
                    setState(() {
                      _isLogIn = !_isLogIn;
                    });
                  },
                ),
            ],
          ),
        ),
      ),
    ));
  }
}
