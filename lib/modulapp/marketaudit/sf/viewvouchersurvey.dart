import 'package:flutter/material.dart';
import 'package:hero/modulapp/coverage/marketaudit/sf/blocsurvey.dart';
import 'package:hero/util/component/label/component_label.dart';

class ViewVoucherSurvey extends StatefulWidget {
  final UISurvey? uiSurvey;
  final EnumSurvey enumSurvey;

  ViewVoucherSurvey(this.enumSurvey, this.uiSurvey);

  @override
  _ViewVoucherSurveyState createState() => _ViewVoucherSurveyState();
}

class _ViewVoucherSurveyState extends State<ViewVoucherSurvey> {
  List<ItemSurveyVoucher>? _lsurvey;
  @override
  void initState() {
    if (widget.enumSurvey == EnumSurvey.fisik) {
      _lsurvey = widget.uiSurvey!.lsurveyFisik;
    } else {
      _lsurvey = widget.uiSurvey!.lsurveyBroadband;
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_lsurvey == null) {
      return Container();
    }
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            _dataTable(_lsurvey!, ''),
            SizedBox(
              height: 150,
            ),
          ],
        ),
      ),
    );
  }

  Widget _dataTable(List<ItemSurveyVoucher> lrek, String title) {
    const TextStyle _tstyleheader = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );
    List<DataRow> ldr = [];
    int tmp = 0;
    for (int i = 0; i < lrek.length; i++) {
      ItemSurveyVoucher element = lrek[i];

      tmp = tmp + 3;
      ldr.add(DataRow(
        cells: <DataCell>[
          DataCell(_label(element.getNama())),
          DataCell(_textField('${element.ld}')),
          DataCell(_textField('${element.md}')),
          DataCell(_textField('${element.hd}')),
        ],
      ));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: LabelApp.size1(
            title,
            bold: true,
          ),
        ),
        Card(
          child: FractionallySizedBox(
            widthFactor: 0.95,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 12,
                dataRowHeight: 80,
                columns: const <DataColumn>[
                  DataColumn(
                    label: Text(
                      '',
                      style: _tstyleheader,
                    ),
                  ),
                  DataColumn(
                    label: Text('LD',
                        style: _tstyleheader, textAlign: TextAlign.center),
                  ),
                  DataColumn(
                    label: Text(
                      'MD',
                      style: _tstyleheader,
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'HD',
                      style: _tstyleheader,
                    ),
                  ),
                ],
                rows: ldr,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _label(String? nama) {
    return LabelApp.size3(nama);
  }

  Widget _textField(String text) {
    return SizedBox(
      width: 60,
      child: LabelApp.size2(
        text,
        bold: true,
      ),
    );
  }
}
