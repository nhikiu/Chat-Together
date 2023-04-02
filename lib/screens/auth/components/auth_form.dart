import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../components/rounded_container.dart';
import '../../../components/rounded_password_field.dart';
import '../../../constants.dart';

class AuthForm extends StatelessWidget {
  AuthForm(
      {super.key,
      required this.formKey,
      required this.isLogIn,
      required this.emailController,
      required this.passwordController,
      required this.usernameController});
  final GlobalKey formKey;
  final bool isLogIn;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController usernameController;

  FormFieldValidator _validateEmail() {
    return (value) {
      if (value == null || value.isEmpty || !value.contains('@')) {
        return 'Please enter a valid email address.';
      }
      return null;
    };
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          RoundedContainer(
            child: TextFormField(
              key: ValueKey('email'),
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              validator: _validateEmail(),
              decoration: InputDecoration(
                hintText: 'Your email',
                icon: Icon(CupertinoIcons.person, color: kPrimaryColor),
                border: InputBorder.none,
              ),
            ),
          ),
          if (!isLogIn)
            RoundedContainer(
              child: TextFormField(
                key: ValueKey('username'),
                controller: usernameController,
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 5) {
                    return 'Username must be at least 5 characters.';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: 'Username',
                  icon: Icon(CupertinoIcons.person, color: kPrimaryColor),
                  border: InputBorder.none,
                ),
              ),
            ),
          RoundedPasswordField(
            key: ValueKey('password'),
            onChanged: (value) {},
            controller: passwordController,
            validator: (value) {
              if (value == null || value.isEmpty || value.length < 8) {
                return 'Password must be at least 8 characters.';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
