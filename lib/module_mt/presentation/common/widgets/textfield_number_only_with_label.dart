import 'package:flutter/material.dart';

class TextFieldNumberOnlyWithLabel extends StatefulWidget {
  final String label;
  final double widthLabel;
  final double widthTextField;
  final TextEditingController controller;
  final Function(String)? onChanged;
  final bool enable;
  final String? validation;

  const TextFieldNumberOnlyWithLabel({
    Key? key,
    required this.widthTextField,
    this.onChanged,
    this.enable = true,
    this.validation,
    required this.controller,
    required this.widthLabel,
    required this.label,
    // required this.controller,
  }) : super(key: key);

  @override
  _TextFieldNumberOnlyWithLabelState createState() =>
      _TextFieldNumberOnlyWithLabelState();
}

class _TextFieldNumberOnlyWithLabelState
    extends State<TextFieldNumberOnlyWithLabel> {
  final TextStyle _labelStyle = const TextStyle(color: Colors.black);
  final TextStyle _textfieldStyle = const TextStyle(fontSize: 14);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: _label(widget.label),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 16.0),
          child: SizedBox(
            width: 15,
            child: Text(':'),
          ),
        ),
        SizedBox(width: widget.widthTextField, child: _entryField()),
      ],
    );
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: SizedBox(
        width: widget.widthLabel,
        child: Text(
          text,
          style: _labelStyle,
        ),
      ),
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
      keyboardType: TextInputType.number,
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
