import 'package:flutter/material.dart';
import 'package:hero/util/component/label/component_label.dart';

class TextArea extends StatefulWidget {
  final Function(String) onChangeText;
  final String label;
  final TextEditingController controller;
  const TextArea(
      {Key? key,
      required this.onChangeText,
      required this.label,
      required this.controller})
      : super(key: key);

  @override
  _TextAreaState createState() => _TextAreaState();
}

class _TextAreaState extends State<TextArea> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: LabelBlack.size2(widget.label),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextFormField(
            controller: widget.controller,
            minLines: 5,
            maxLines: 5,
            keyboardType: TextInputType.multiline,
            decoration: const InputDecoration(
                hintText: 'Enter A Message Here',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                )),
          ),
        ),
      ],
    );
  }
}
