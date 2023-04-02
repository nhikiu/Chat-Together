import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './rounded_container.dart';
import '../constants.dart';

class RoundedPasswordField extends StatefulWidget {
  const RoundedPasswordField({
    super.key,
    this.title = 'Password',
    required this.onChanged,
    required this.validator,
    required this.controller,
  });

  final ValueChanged<String> onChanged;
  final String title;
  final TextEditingController controller;
  final FormFieldValidator validator;

  @override
  State<RoundedPasswordField> createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  var _visibilityPassword = true;
  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
        child: TextFormField(
      onChanged: widget.onChanged,
      validator: widget.validator,
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.title,
        icon: Icon(
          CupertinoIcons.lock,
          color: kPrimaryColor,
        ),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _visibilityPassword = !_visibilityPassword;
            });
          },
          icon: Icon(
              _visibilityPassword ? Icons.visibility : Icons.visibility_off),
          color: kPrimaryColor,
        ),
        border: InputBorder.none,
      ),
      obscureText: _visibilityPassword,
    ));
  }
}
