import 'package:flutter/material.dart';

import '../constants.dart';

class RoundedContainer extends StatelessWidget {
  const RoundedContainer(
      {super.key, required this.child, this.color = kPrimaryLightColor});

  final Widget child;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final Size sizeMediaQuery = MediaQuery.of(context).size;

    return Container(
      height: 60,
      width: sizeMediaQuery.width * 0.8,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(30)),
      child: child,
    );
  }
}
