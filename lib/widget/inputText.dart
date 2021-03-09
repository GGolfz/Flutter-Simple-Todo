import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  final controller;
  final labelText;
  final isPassword;
  InputText(
      {@required this.controller,
      @required this.labelText,
      this.isPassword = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 12),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Color(0xFFD5D8DE))),
        ),
      ),
    );
  }
}
