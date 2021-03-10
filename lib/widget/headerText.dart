import 'package:flutter/material.dart';
import '../config/color.dart';

class HeaderText extends StatelessWidget {
  final titleText;
  final subtitleText;
  final ratio;
  HeaderText({this.titleText, this.subtitleText, this.ratio = 1.0});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(children: [
            Text(titleText,
                style: TextStyle(color: primaryColor, fontSize: 32 * ratio))
          ]),
          Row(children: [
            Text(subtitleText, style: TextStyle(fontSize: 16 * ratio))
          ])
        ],
      ),
    );
  }
}
