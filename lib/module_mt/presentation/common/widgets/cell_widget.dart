import 'package:flutter/material.dart';
import 'package:hero/util/component/label/component_label.dart';

class CellDuaColumn extends StatelessWidget {
  final double widthFirsComponent;
  final String label;
  final String value;
  const CellDuaColumn(
      {Key? key,
      required this.widthFirsComponent,
      required this.label,
      required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: widthFirsComponent, child: LabelApp.size1(label)),
        const SizedBox(
          width: 15,
          child: Text(':'),
        ),
        Expanded(
          child: LabelApp.size1(value),
        ),
      ],
    );
  }
}

class DynamicTwoColumn extends StatelessWidget {
  final double widthFirsComponent;
  final String label;
  final Widget widget;
  const DynamicTwoColumn(
      {Key? key,
      required this.widthFirsComponent,
      required this.label,
      required this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 70, child: LabelApp.size1(label)),
        const SizedBox(
          width: 15,
          child: Text(':'),
        ),
        Expanded(
          child: widget,
        ),
      ],
    );
  }
}
