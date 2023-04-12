import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../components/rounded_button.dart';
import '../../../constants.dart';
import '../../auth/auth_screen.dart';
import '../../welcome/components/welcome_background.dart';

class WelcomeBody extends StatelessWidget {
  const WelcomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    Size sizeMediaQuery = MediaQuery.of(context).size;
    return WelcomeBackground(
        centerBody: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'WELCOME TO CHAT TOGETHER',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: sizeMediaQuery.height * 0.1,
        ),
        SvgPicture.asset(
          'assets/icons/chat.svg',
          height: sizeMediaQuery.height * 0.45,
        ),
        SizedBox(
          height: sizeMediaQuery.height * 0.05,
        ),
        RoundedButton(
          title: 'Start chat',
          press: () {
            Navigator.of(context).pushNamed(AuthScreen.routeName);
          },
          textColor: Colors.white,
          backgroundColor: kPrimaryColor,
        ),
      ],
    ));
  }
}
