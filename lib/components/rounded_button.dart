import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton(
      {super.key,
      required this.title,
      required this.press,
      required this.backgroundColor,
      required this.textColor});

  final String title;
  final VoidCallback press;
  final Color backgroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    Size sizeMediaQuery = MediaQuery.of(context).size;

    return Container(
      width: sizeMediaQuery.width * 0.8,
      height: 60,
      margin: EdgeInsets.symmetric(vertical: 5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: ElevatedButton(
          onPressed: press,
          child: Text(
            title,
            style: TextStyle(color: textColor),
          ),
          style: ButtonStyle(
            backgroundColor:
                MaterialStateColor.resolveWith((states) => backgroundColor),
          ),
        ),
      ),
    );
  }
}
