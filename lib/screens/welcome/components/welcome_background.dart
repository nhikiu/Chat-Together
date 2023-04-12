import 'package:flutter/material.dart';

class WelcomeBackground extends StatelessWidget {
  final Widget centerBody;

  const WelcomeBackground({super.key, required this.centerBody});

  @override
  Widget build(BuildContext context) {
    Size sizeMediaQuery = MediaQuery.of(context).size;
    return SizedBox(
      height: sizeMediaQuery.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 0,
            top: 0,
            width: sizeMediaQuery.width * 0.3,
            child: Image.asset('assets/images/main_top.png'),
          ),
          Positioned(
            left: 0,
            bottom: 0,
            width: sizeMediaQuery.width * 0.2,
            child: Image.asset('assets/images/main_bottom.png'),
          ),
          centerBody
        ],
      ),
    );
  }
}
