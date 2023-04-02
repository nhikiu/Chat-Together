import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {
  const AuthBackground({
    super.key,
    required this.centerBody,
  });

  final Widget centerBody;

  @override
  Widget build(BuildContext context) {
    final Size sizeMediaQuery = MediaQuery.of(context).size;

    return Container(
      height: sizeMediaQuery.height,
      width: double.infinity,
      child: Scaffold(
          body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
              top: 0,
              left: 0,
              height: sizeMediaQuery.height * 0.2,
              child: Image.asset('assets/images/main_top.png')),
          Positioned(
              right: 0,
              bottom: 0,
              height: sizeMediaQuery.height * 0.2,
              child: Image.asset('assets/images/login_bottom.png')),
          centerBody
        ],
      )),
    );
  }
}
