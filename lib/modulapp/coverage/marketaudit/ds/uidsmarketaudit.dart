import 'package:flutter/material.dart';
import 'package:hero/modulapp/coverage/marketaudit/ds/blocdsmarketaudit.dart';
import 'package:hero/modulapp/coverage/merchandising/blocmerchandising.dart';
import 'package:hero/util/component/component_label.dart';
import 'package:hero/util/component/component_textfield.dart';
import 'package:hero/util/component/component_widget.dart';

class CoverageMarketAudit extends StatefulWidget {
  @override
  _CoverageMarketAuditState createState() => _CoverageMarketAuditState();
}

class _CoverageMarketAuditState extends State<CoverageMarketAudit> {
  TextEditingController _namaController = TextEditingController();
  TextEditingController _nelponController = TextEditingController();
  TextEditingController _internetController = TextEditingController();
  TextEditingController _gamesController = TextEditingController();
  TextEditingController _quotaController = TextEditingController();
  TextEditingController _rpController = TextEditingController();

  EnumOperator? _nelpon;
  EnumOperator? _internet;
  EnumOperator? _games;

  EnumSering? _enumSering;

  @override
  void initState() {
    _nelpon = EnumOperator.telkomsel;
    _internet = EnumOperator.telkomsel;
    _games = EnumOperator.telkomsel;
    _enumSering = EnumSering.bulanan;
    super.initState();
  }

  @override
  void dispose() {
    _namaController.dispose();
    super.dispose();
  }

  void _handleClickRadioButton(EnumDSMA enumDSMA, EnumOperator? enumOperator) {
    switch (enumDSMA) {
      case EnumDSMA.nelpon:
        setState(() {
          _nelpon = enumOperator;
        });
        break;
      case EnumDSMA.internet:
        setState(() {
          _internet = enumOperator;
        });
        break;
      case EnumDSMA.games:
        setState(() {
          _games = enumOperator;
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'Market Audit',
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                _spasi(),
                _textField('Nama Pelanggan', _namaController),
                _spasi(),
                _radioOperator('Operator Nelpon', EnumDSMA.nelpon),
                _spasi(),
                _textFieldNumberOnly('MSISDN Nelpon', _nelponController),
                _spasi(),
                _radioOperator('Operator Internet', EnumDSMA.internet),
                _spasi(),
                _textFieldNumberOnly('MSISDN Internet', _internetController),
                _spasi(),
                _radioOperator(
                    'Operator Digital (Games & Video)', EnumDSMA.games),
                _spasi(),
                _textFieldNumberOnly(
                    'MSISDN Digital (Games & Video)', _gamesController),
                _spasi(),
                _radioSering(),
                _spasi(),
                _textFieldNumberOnly(
                    'Berapa GB kebutuhan Quota 1 bulan', _quotaController),
                _spasi(),
                _textFieldNumberOnly(
                    'Berapa Rupiah kebutuhan Pulsa 1 bulan', _rpController),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _textFieldNumberOnly(String label, TextEditingController controller) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFieldNormalNumberOnly(label, controller),
    ));
  }

  Widget _textField(String label, TextEditingController controller) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          _labelKetValue('ID Sekolah/Kampus :', 'SEK00004'),
          Divider(),
          TextFieldNormal(label, controller),
        ],
      ),
    ));
  }

  Widget _labelKetValue(String ket, String value) {
    return Row(
      children: [
        LabelApp.size2(ket),
        LabelApp.size2(value),
      ],
    );
  }

  Widget _radioOperator(String label, EnumDSMA enumDSMA) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: LabelApp.size2(label),
          ),
          Divider(),
          Row(
            children: [
              __barisRadio(EnumOperator.telkomsel, enumDSMA),
              SizedBox(
                width: 8,
              ),
              __barisRadio(EnumOperator.isat, enumDSMA),
            ],
          ),
          Row(
            children: [
              __barisRadio(EnumOperator.xl, enumDSMA),
              SizedBox(
                width: 8,
              ),
              __barisRadio(EnumOperator.tri, enumDSMA),
              SizedBox(
                width: 8,
              ),
              __barisRadio(EnumOperator.sf, enumDSMA),
            ],
          ),
        ],
      ),
    );
  }

  Widget _radioSering() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: LabelApp.size2('Sering membeli paket apa ?'),
              ),
              Divider(),
              Row(
                children: [
                  __barisRadioSering(EnumSering.harian),
                  SizedBox(
                    width: 8,
                  ),
                  __barisRadioSering(EnumSering.mingguan),
                  SizedBox(
                    width: 8,
                  ),
                  __barisRadioSering(EnumSering.bulanan),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget __barisRadio(EnumOperator enumOperator, EnumDSMA enumDSMA) {
    String label = '';
    switch (enumOperator) {
      case EnumOperator.telkomsel:
        label = 'Telkomsel';
        break;
      case EnumOperator.tri:
        label = 'Tri';
        break;
      case EnumOperator.isat:
        label = 'Indosat';
        break;
      case EnumOperator.xl:
        label = 'XL';
        break;
      case EnumOperator.sf:
        label = 'Smartfren';
        break;
      case EnumOperator.axis:
        label = 'Axis';
        break;
      case EnumOperator.other:
        label = 'Other';
        break;
    }
    EnumOperator? groupField;
    switch (enumDSMA) {
      case EnumDSMA.nelpon:
        groupField = _nelpon;
        break;
      case EnumDSMA.internet:
        groupField = _internet;
        break;
      case EnumDSMA.games:
        groupField = _games;
        break;
    }
    return Row(
      children: [
        Radio<EnumOperator>(
          value: enumOperator,
          groupValue: groupField,
          onChanged: (EnumOperator? value) {
            print('DSMA : $enumDSMA || value: $value');
            _handleClickRadioButton(enumDSMA, value);
          },
        ),
        LabelApp.size2(label),
      ],
    );
  }

  Widget __barisRadioSering(EnumSering enumSering) {
    String label = '';
    switch (enumSering) {
      case EnumSering.harian:
        label = 'Harian';
        break;
      case EnumSering.mingguan:
        label = 'Mingguan';
        break;
      case EnumSering.bulanan:
        label = 'Bulanan';
        break;
    }

    return Row(
      children: [
        Radio<EnumSering>(
          value: enumSering,
          groupValue: _enumSering,
          onChanged: (EnumSering? value) {
            setState(() {
              _enumSering = value;
            });
          },
        ),
        LabelApp.size2(label),
      ],
    );
  }

  Widget _spasi() {
    return SizedBox(
      height: 16,
    );
  }
}
