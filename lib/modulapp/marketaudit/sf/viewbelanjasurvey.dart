import 'package:flutter/material.dart';
import 'package:hero/modulapp/coverage/marketaudit/sf/blocsurvey.dart';
import 'package:hero/modulapp/coverage/merchandising/blocmerchandising.dart';
import 'package:hero/util/component/component_label.dart';
import 'package:hero/util/component/component_widget.dart';

class ViewBelanjaSurvey extends StatefulWidget {
  final UISurvey? uiSurvey;
  ViewBelanjaSurvey(
    this.uiSurvey,
  );
  @override
  _ViewBelanjaSurveyState createState() => _ViewBelanjaSurveyState();
}

class _ViewBelanjaSurveyState extends State<ViewBelanjaSurvey> {
  UISurvey? _item;
  @override
  void initState() {
    _item = widget.uiSurvey;

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _cardForm(s.width),
            SizedBox(
              height: 12,
            ),
            _listPhoto(s.width),
            SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }

  Widget _cardForm(double width) {
    double w = width - 120;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _cellForm(w, 'Telkomsel', EnumOperator.telkomsel),
            _cellForm(w, 'Isat', EnumOperator.isat),
            _cellForm(w, 'XL', EnumOperator.xl),
            _cellForm(w, '3', EnumOperator.tri),
            _cellForm(w, 'Smartfren', EnumOperator.sf),
            _cellForm(w, 'Axis', EnumOperator.axis),
            _cellForm(w, 'Other', EnumOperator.other),
          ],
        ),
      ),
    );
  }

  Widget _cellForm(double width, String label, EnumOperator enumOperator) {
    String text = '';
    switch (enumOperator) {
      case EnumOperator.telkomsel:
        text = '${_item!.telkomsel}';
        break;
      case EnumOperator.tri:
        text = '${_item!.tri}';
        break;
      case EnumOperator.isat:
        text = '${_item!.isat}';
        break;
      case EnumOperator.xl:
        text = '${_item!.xl}';
        break;
      case EnumOperator.sf:
        text = '${_item!.sf}';
        break;
      case EnumOperator.axis:
        text = '${_item!.axis}';
        break;
      case EnumOperator.other:
        text = '${_item!.other}';
        break;
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          SizedBox(width: 80, child: LabelBlack.size2(label)),
          SizedBox(
            width: 20,
          ),
          LabelApp.size2(
            text,
            bold: true,
          )
        ],
      ),
    );
  }

  Widget _listPhoto(double width) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ContainerRounded(
          borderColor: Colors.black,
          radius: 4.0,
          child: FractionallySizedBox(
              widthFactor: 0.9,
              child: Image.network(
                _item!.pathphotobelanja!,
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return Container();
                },
              )),
        ),
      ),
    );
  }
}
