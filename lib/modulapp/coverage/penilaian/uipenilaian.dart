import 'package:flutter/material.dart';
import 'package:hero/model/penilaian.dart';
import 'package:hero/modulapp/coverage/penilaian/blocpenilaian.dart';
import 'package:hero/util/component/component_label.dart';
import 'package:hero/util/component/component_textfield.dart';
import 'package:hero/util/component/component_widget.dart';

class UIPenilaian extends StatefulWidget {
  @override
  _UIPenilaianState createState() => _UIPenilaianState();
}

class _UIPenilaianState extends State<UIPenilaian> {
  List<TextEditingController>? _lcontrollerPersonaliti;
  List<TextEditingController>? _lcontrollerDistribusi;
  List<TextEditingController>? _lcontrollerMerchandising;
  List<TextEditingController>? _lcontrollerPromotion;

  @override
  void initState() {
    _lcontrollerPersonaliti = [];
    _lcontrollerDistribusi = [];
    _lcontrollerMerchandising = [];
    _lcontrollerPromotion = [];
    _setupTextController();
    super.initState();
  }

  void _setupTextController() {
    for (int i = 0; i < 4; i++) {
      _lcontrollerPersonaliti!.add(TextEditingController());
    }

    for (int i = 0; i < 3; i++) {
      _lcontrollerDistribusi!.add(TextEditingController());
    }

    for (int i = 0; i < 3; i++) {
      _lcontrollerMerchandising!.add(TextEditingController());
    }

    for (int i = 0; i < 2; i++) {
      _lcontrollerPromotion!.add(TextEditingController());
    }
  }

  @override
  void dispose() {
    _lcontrollerPersonaliti!.forEach((element) {
      element.dispose();
    });

    _lcontrollerDistribusi!.forEach((element) {
      element.dispose();
    });

    _lcontrollerMerchandising!.forEach((element) {
      element.dispose();
    });

    _lcontrollerPromotion!.forEach((element) {
      element.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ItemPenilaian itemPenilaian = ItemPenilaian.empty();

    return CustomScaffold(
        body: Container(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  _cardPenilaian('Personality', itemPenilaian.lpersonality,
                      EnumPenilaian.personality),
                  _spasi(),
                  _cardPenilaian('Distribution', itemPenilaian.ldistribusi,
                      EnumPenilaian.distribusi),
                  _spasi(),
                  _cardPenilaian('Merchandising', itemPenilaian.lmerchandising,
                      EnumPenilaian.merchandising),
                  _spasi(),
                  _cardPenilaian('Promotion', itemPenilaian.lpromotion,
                      EnumPenilaian.promotion),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ),
        title: 'Penilaian');
  }

  Widget _cardPenilaian(
      String label, List<MPenilaian>? lpenilaian, EnumPenilaian enumPenilaian) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            LabelApp.size1(
              label,
              bold: true,
            ),
            Divider(),
            _fieldPenilaian(lpenilaian, enumPenilaian),
          ],
        ),
      ),
    );
  }

  Widget _fieldPenilaian(
      List<MPenilaian>? lpenilaian, EnumPenilaian enumPenilaian) {
    List<TextEditingController>? lcontroller;
    switch (enumPenilaian) {
      case EnumPenilaian.personality:
        lcontroller = _lcontrollerPersonaliti;
        break;
      case EnumPenilaian.distribusi:
        lcontroller = _lcontrollerDistribusi;
        break;
      case EnumPenilaian.merchandising:
        lcontroller = _lcontrollerMerchandising;
        break;
      case EnumPenilaian.promotion:
        lcontroller = _lcontrollerPromotion;
        break;
    }
    List<Widget> lw = [];
    if (lpenilaian!.length == lcontroller!.length) {
      for (int i = 0; i < lcontroller.length; i++) {
        lw.add(_cell(lpenilaian[i], lcontroller[i]));
      }
    }

    return Column(
      children: lw,
    );
  }

  Widget _cell(MPenilaian penilaian, TextEditingController controller) {
    return TextFieldNormalNumberOnly(penilaian.parameter, controller);
  }

  Widget _spasi() {
    return SizedBox(
      height: 16,
    );
  }
}
