import 'package:flutter/material.dart';

import '../constants.dart';

class AlreadyAnAccountCheck extends StatelessWidget {
  const AlreadyAnAccountCheck({
    super.key,
    this.login = true,
    required this.press,
  });

  final bool login;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          login ? 'Don\'t have an account ?' : 'Already have an account ?',
          style: const TextStyle(color: kPrimaryColor),
        ),
        const SizedBox(
          width: 5,
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            login ? 'Sign Up' : 'Log In',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: kPrimaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
