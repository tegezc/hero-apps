import 'package:flutter/material.dart';
import 'package:hero/util/component/label/component_label.dart';
import 'package:hero/util/component/widget/component_widget.dart';

class PageMtError extends StatelessWidget {
  final String message;
  const PageMtError({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldMT(
      body: Container(
        child: LabelBlack.title(message),
      ),
      title: 'Error',
    );
  }
}
