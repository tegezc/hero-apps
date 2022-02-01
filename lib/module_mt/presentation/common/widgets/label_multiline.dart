import 'package:flutter/material.dart';

class LabelMultiline extends StatelessWidget {
  final String text;

  const LabelMultiline(this.text, {Key? key}) : super(key: key);

  final TextStyle _labelStyle = const TextStyle(color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: _labelStyle,
    );
  }
}
