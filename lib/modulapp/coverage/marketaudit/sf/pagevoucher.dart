import 'package:flutter/material.dart';
import 'package:hero/modulapp/camera/loadingview.dart';
import 'package:hero/util/component/button/component_button.dart';
import 'package:hero/util/component/label/component_label.dart';
import 'package:hero/util/component/textfield/component_textfield.dart';
import 'package:hero/util/component/widget/widget_success_submit.dart';

import 'blocsurvey.dart';

class PageVoucherSurvey extends StatefulWidget {
  final UISurvey? uiSurvey;
  final BlocSurvey? blocSurvey;
  final EnumSurvey enumSurvey;

  const PageVoucherSurvey(this.uiSurvey, this.blocSurvey, this.enumSurvey);

  @override
  _PageVoucherSurveyState createState() => _PageVoucherSurveyState();
}

class _PageVoucherSurveyState extends State<PageVoucherSurvey> {
  late List<TextEditingController> _lcontroller;

  UISurvey? _item;
  bool _issubmitbuttonshowing = true;

  int _countBuild = 0;

  BlocSurvey? _blocSurvey;

  @override
  void initState() {
    _blocSurvey = widget.blocSurvey;
    _item = widget.uiSurvey;
    _lcontroller = [];
    if (widget.enumSurvey == EnumSurvey.broadband) {
      _issubmitbuttonshowing = _item!.isbroadbandsubmitted;
    } else {
      _issubmitbuttonshowing = _item!.isfisiksubmitted;
    }

    print("_issubmitbuttonshowing $_issubmitbuttonshowing");
    for (int i = 0; i < 21; i++) {
      _lcontroller.add(TextEditingController());
    }

    super.initState();
  }

  void _setvalue() {
    List<ItemSurveyVoucher>? lsurvey = [];
    if (widget.enumSurvey == EnumSurvey.broadband) {
      lsurvey = _item!.lsurveyBroadband;
    } else {
      lsurvey = _item!.lsurveyFisik;
    }
    _lcontroller[0].text = lsurvey![0].ld == null ? '' : '${lsurvey[0].ld}';
    _lcontroller[1].text = lsurvey[0].md == null ? '' : '${lsurvey[0].md}';
    _lcontroller[2].text = lsurvey[0].hd == null ? '' : '${lsurvey[0].hd}';
    _lcontroller[3].text = lsurvey[1].ld == null ? '' : '${lsurvey[1].ld}';
    _lcontroller[4].text = lsurvey[1].md == null ? '' : '${lsurvey[1].md}';
    _lcontroller[5].text = lsurvey[1].hd == null ? '' : '${lsurvey[1].hd}';
    _lcontroller[6].text = lsurvey[2].ld == null ? '' : '${lsurvey[2].ld}';
    _lcontroller[7].text = lsurvey[2].md == null ? '' : '${lsurvey[2].md}';
    _lcontroller[8].text = lsurvey[2].hd == null ? '' : '${lsurvey[2].hd}';
    _lcontroller[9].text = lsurvey[3].ld == null ? '' : '${lsurvey[3].ld}';
    _lcontroller[10].text = lsurvey[3].md == null ? '' : '${lsurvey[3].md}';
    _lcontroller[11].text = lsurvey[3].hd == null ? '' : '${lsurvey[3].hd}';
    _lcontroller[12].text = lsurvey[4].ld == null ? '' : '${lsurvey[4].ld}';
    _lcontroller[13].text = lsurvey[4].md == null ? '' : '${lsurvey[4].md}';
    _lcontroller[14].text = lsurvey[4].hd == null ? '' : '${lsurvey[4].hd}';
    _lcontroller[15].text = lsurvey[5].ld == null ? '' : '${lsurvey[5].ld}';
    _lcontroller[16].text = lsurvey[5].md == null ? '' : '${lsurvey[5].md}';
    _lcontroller[17].text = lsurvey[5].hd == null ? '' : '${lsurvey[5].hd}';
    _lcontroller[18].text = lsurvey[6].ld == null ? '' : '${lsurvey[6].ld}';
    _lcontroller[19].text = lsurvey[6].md == null ? '' : '${lsurvey[6].md}';
    _lcontroller[20].text = lsurvey[6].hd == null ? '' : '${lsurvey[6].hd}';
  }

  bool _isbolehsubmit() {
    bool adanull = false;
    _lcontroller.forEach((element) {
      if (!adanull) {
        print('element != null');
        int? value = int.tryParse(element.text);
        if (value == null) {
          adanull = true;
        }
      }
    });
    return !adanull;
  }

  @override
  void dispose() {
    for (int i = 0; i < 21; i++) {
      _lcontroller[i].dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_countBuild == 0) {
      _setvalue();
      _countBuild++;
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          _issubmitbuttonshowing ? _successDisubmit() : Container(),
          _dataTable(_item!.lsurveyBroadband!, ''),
          _issubmitbuttonshowing
              ? Container()
              : ButtonStrectWidth(
                  buttonColor: Colors.red,
                  text: "SUBMIT",
                  onTap: () {
                    // for (int i = 0; i < _lcontroller.length; i++) {
                    //   String str = _lcontroller[i].text;
                    //   widget.blocSurvey.changedText(i, str, widget.enumSurvey);
                    // }
                    print(_isbolehsubmit());
                    if (_isbolehsubmit()) {
                      TgzDialog.loadingDialog(context);
                      _blocSurvey!
                          .submitVoucher(widget.enumSurvey)
                          .then((value) {
                        Navigator.of(context).pop();
                        if (value) {
                          _confirmSuccessSimpan();
                        } else {
                          _confirmGagalMenyimpan();
                        }
                      });
                    } else {
                      TgzDialog.confirmHarusDiisi(context);
                    }
                  },
                  isenable: true),
          const SizedBox(
            height: 150,
          ),
        ],
      ),
    );
  }

  Widget _successDisubmit() {
    return const Padding(
      padding: EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0),
      child: WidgeSuccessSubmit(),
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
      int i1 = tmp;
      int i2 = tmp + 1;
      int i3 = tmp + 2;
      tmp = tmp + 3;
      ldr.add(DataRow(
        cells: <DataCell>[
          DataCell(_label(element.getNama())),
          DataCell(_textField(element, i1)),
          DataCell(_textField(element, i2)),
          DataCell(_textField(element, i3)),
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

  Widget _textField(ItemSurveyVoucher item, int index) {
    return SizedBox(
      width: 60,
      child: TextFieldNumberOnly(
        '',
        _lcontroller[index],
        onChanged: (str) {
          _blocSurvey!.changedText(index, str, widget.enumSurvey);
        },
      ),
    );
  }

  _confirmSuccessSimpan() {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => SimpleDialog(
              title: LabelApp.size1(
                'Confirm',
                color: Colors.green,
              ),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0, left: 16.0, bottom: 3.0),
                  child: LabelBlack.size2('Market Audit berhasil disimpan.'),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0, left: 16.0, bottom: 3.0),
                  child: ButtonApp.black('Ok', () {
                    Navigator.of(context).pop();
                    _blocSurvey!.refresh();
                  }),
                ),
              ],
            ));
  }

  _confirmGagalMenyimpan() {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => SimpleDialog(
              title: LabelApp.size1(
                'Confirm',
                color: Colors.red,
              ),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0, left: 16.0, bottom: 3.0),
                  child: LabelBlack.size2('Market Audit gagal disimpan.'),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0, left: 16.0, bottom: 3.0),
                  child: ButtonApp.black('Ok', () {
                    Navigator.of(context).pop();
                  }),
                ),
              ],
            ));
  }
}
