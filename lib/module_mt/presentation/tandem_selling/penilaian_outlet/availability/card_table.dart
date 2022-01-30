import 'package:flutter/material.dart';
import 'package:hero/module_mt/domain/entity/tandem_selling/kategories.dart';
import 'package:hero/module_mt/presentation/tandem_selling/common/widget_textfield_withlabel.dart';
import 'package:hero/util/component/label/component_label.dart';

class CardTableParameter extends StatefulWidget {
  final String title;
  final Kategories kategories;
  const CardTableParameter(
      {Key? key, required this.title, required this.kategories})
      : super(key: key);

  @override
  _CardTableParameterState createState() => _CardTableParameterState();
}

class _CardTableParameterState extends State<CardTableParameter> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Column(
        children: _recordsParam(),
      ),
    );
  }

  List<Widget> _recordsParam() {
    Size s = MediaQuery.of(context).size;
    double widthLabel = 80;
    double widthTextField = s.width - 110;
    List<Widget> lw = [];
    lw.add(LabelBlack.size1(widget.title));
    lw.add(const Divider());
    for (int i = 0; i < widget.kategories.lparams.length; i++) {
      lw.add(TextFieldNumberOnlyWithLabel(
          widthLabel: widthLabel,
          widthTextField: widthTextField,
          // controller: _controller,
          label: 'Telkomsel'));
    }
    return lw;
  }
}
