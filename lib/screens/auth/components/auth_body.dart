import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../components/already_have_an_account.dart';
import '../../../components/rounded_button.dart';
import '../../../components/rounded_container.dart';
import '../../../components/rounded_password_field.dart';
import '../../../constants.dart';
import './auth_background.dart';

class AuthBody extends StatefulWidget {
  const AuthBody({
    super.key,
    required this.submitUser,
    required this.isLoading,
  });
  final bool isLoading;
  final void Function(String email, String username, String password,
      bool isAuth, BuildContext context) submitUser;

  @override
  State<AuthBody> createState() => _AuthBodyState();
}

class _AuthBodyState extends State<AuthBody> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  var _isLogIn = true;

  //enable validator
  void _trySubmit(BuildContext context) {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      widget.submitUser(
        _emailController.text.trim(),
        _usernameController.text.trim(),
        _passwordController.text.trim(),
        _isLogIn,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size sizeMediaQuery = MediaQuery.of(context).size;

    return AuthBackground(
        centerBody: SafeArea(
      child: SingleChildScrollView(
        child: Container(
          height: sizeMediaQuery.height,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _isLogIn ? 'LOG IN' : 'SIGN UP',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: sizeMediaQuery.height * 0.05,
              ),
              SvgPicture.asset(
                'assets/icons/login.svg',
                height: sizeMediaQuery.height * 0.3,
              ),
              SizedBox(
                height: sizeMediaQuery.height * 0.05,
              ),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    RoundedContainer(
                      child: TextFormField(
                        key: ValueKey('email'),
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              !value.contains('@')) {
                            return 'Please enter a valid email address.';
                          }
                          return null;
                        },
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
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length < 5) {
                              return 'Username must be at least 5 characters.';
                            }
                            return null;
                          },
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
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 8) {
                          return 'Password must be at least 8 characters.';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: sizeMediaQuery.height * 0.01,
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
