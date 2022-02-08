import 'package:flutter/material.dart';

class TextFieldWithlabel extends StatefulWidget {
  final double widthTextField;
  final TextEditingController controller;
  final Function(String)? onChanged;
  final bool enable;
  final String? validation;

  const TextFieldWithlabel({
    Key? key,
    required this.widthTextField,
    this.onChanged,
    this.enable = true,
    this.validation,
    required this.controller,
    // required this.controller,
  }) : super(key: key);

  @override
  _TextFieldWithlabelState createState() => _TextFieldWithlabelState();
}

class _TextFieldWithlabelState extends State<TextFieldWithlabel> {
  final TextStyle _textfieldStyle = const TextStyle(fontSize: 14);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: widget.widthTextField, child: _entryField()),
      ],
    );
  }

  Widget _entryField() {
    return TextFormField(
      enabled: widget.enable,
      style: _textfieldStyle,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: widget.controller,
      onSaved: (str) {},
      validator: (value) {
        return widget.validation;
      },
      onChanged: (str) {
        if (widget.onChanged != null) {
          widget.onChanged!(str);
        }
      },
      maxLines: 1,
      // controller: controller,
      keyboardType: TextInputType.name,
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        // labelText: text,
        isDense: true,
      ),
    );
  }
}
