import 'package:flutter/material.dart';
import 'package:hero/http/coverage/httpdashboard.dart';
import 'package:hero/model/enumapp.dart';
import 'package:hero/modulapp/camera/loadingview.dart';
import 'package:hero/modulapp/coverage/marketaudit/ds/blocdsmarketaudit.dart';
import 'package:hero/util/component/button/component_button.dart';
import 'package:hero/util/component/label/component_label.dart';
import 'package:hero/util/component/textfield/component_textfield.dart';
import 'package:hero/util/component/tgzdialog.dart';
import 'package:hero/util/component/widget/component_widget.dart';

class CoverageMarketAudit extends StatefulWidget {
  static const routeName = '/dsmarketaudit';
  const CoverageMarketAudit({Key? key}) : super(key: key);

  @override
  _CoverageMarketAuditState createState() => _CoverageMarketAuditState();
}

class _CoverageMarketAuditState extends State<CoverageMarketAudit> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _nelponController = TextEditingController();
  final TextEditingController _internetController = TextEditingController();
  final TextEditingController _gamesController = TextEditingController();
  final TextEditingController _quotaController = TextEditingController();
  final TextEditingController _rpController = TextEditingController();

  int _counterBuild = 0;

  final BlocDsQuisioner _blocDsQuisioner = BlocDsQuisioner();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _namaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_counterBuild == 0) {
      _blocDsQuisioner.firstTime();
      _counterBuild++;
    }
    return StreamBuilder<ModelUiQuisioner?>(
        stream: _blocDsQuisioner.modelUiQuisioner,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const LoadingNunggu("Mohon tunggu\nSedang loading data.");
          } else {
            ModelUiQuisioner? item = snapshot.data;
            switch (item!.enumStateWidget) {
              case EnumStateWidget.startup:
                return const LoadingNunggu(
                    "Mohon tunggu\nSedang loading data.");
              case EnumStateWidget.active:
                return const LoadingNunggu(
                    "Mohon tunggu\nSedang loading data.");
              case EnumStateWidget.loading:
                return const LoadingNunggu(
                    "Mohon tunggu\nSedang loading data.");

              case EnumStateWidget.done:
                return CustomScaffold(
                  title: 'Market Audit',
                  body: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          _spasi(),
                          _textField('Nama Pelanggan', _namaController),
                          _spasi(),
                          Card(
                            elevation: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: LabelApp.size1("Operator Nelpon"),
                                ),
                                const Divider(),
                                Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: LabelApp.size2("Operator *"),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: DropdownButton(
                                        items: item.getListOperator().isEmpty
                                            ? null
                                            : item
                                                .getListOperator()
                                                .map(
                                                    (value) => DropdownMenuItem(
                                                          child:
                                                              LabelBlack.size2(
                                                                  value.nama),
                                                          value: value,
                                                        ))
                                                .toList(),
                                        onChanged: (dynamic item) {
                                          setState(() {
                                            _blocDsQuisioner
                                                .changeComboOperatorNelpon(
                                                    item);
                                          });
                                        },
                                        value: item.getCurrentOperatorNelpon(),
                                        isExpanded: false,
                                        hint: const LabelBlack.size2(
                                            'Pilih Operator'),
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFieldNormalNumberOnly(
                                      "MSISDN Nelpon *", _nelponController),
                                ),
                              ],
                            ),
                          ),
                          _spasi(),
                          Card(
                            elevation: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: LabelApp.size1("Operator Internet"),
                                ),
                                const Divider(),
                                Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: LabelApp.size2("Operator *"),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: DropdownButton(
                                        items: item.getListOperator().isEmpty
                                            ? null
                                            : item
                                                .getListOperator()
                                                .map(
                                                    (value) => DropdownMenuItem(
                                                          child:
                                                              LabelBlack.size2(
                                                                  value.nama),
                                                          value: value,
                                                        ))
                                                .toList(),
                                        onChanged: (dynamic item) {
                                          setState(() {
                                            _blocDsQuisioner
                                                .changeComboOperatorInternet(
                                                    item);
                                          });
                                        },
                                        value:
                                            item.getCurrentOperatorInternet(),
                                        isExpanded: false,
                                        hint: const LabelBlack.size2(
                                            'Pilih Operator'),
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFieldNormalNumberOnly(
                                      "MSISDN Internet *", _internetController),
                                ),
                              ],
                            ),
                          ),
                          _spasi(),
                          Card(
                            elevation: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: LabelApp.size1(
                                      "Operator Digital (Games & Video)"),
                                ),
                                const Divider(),
                                Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: LabelApp.size2("Operator *"),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: DropdownButton(
                                        items: item.getListOperator().isEmpty
                                            ? null
                                            : item
                                                .getListOperator()
                                                .map(
                                                    (value) => DropdownMenuItem(
                                                          child:
                                                              LabelBlack.size2(
                                                                  value.nama),
                                                          value: value,
                                                        ))
                                                .toList(),
                                        onChanged: (dynamic item) {
                                          setState(() {
                                            _blocDsQuisioner
                                                .changeComboOperatorDigital(
                                                    item);
                                          });
                                        },
                                        value: item.getCurrentOperatorDigital(),
                                        isExpanded: false,
                                        hint: const LabelBlack.size2(
                                            'Pilih Operator'),
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFieldNormalNumberOnly(
                                      "MSISDN Digital (Games & Video) *",
                                      _gamesController),
                                ),
                              ],
                            ),
                          ),
                          _spasi(),
                          Card(
                            elevation: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: LabelApp.size1(
                                      "Sering membeli paket apa?"),
                                ),
                                const Divider(),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: DropdownButton(
                                    items: item.getListFrekuensi().isEmpty
                                        ? null
                                        : item
                                            .getListFrekuensi()
                                            .map((value) => DropdownMenuItem(
                                                  child: LabelBlack.size2(
                                                      value.nama),
                                                  value: value,
                                                ))
                                            .toList(),
                                    onChanged: (dynamic item) {
                                      setState(() {
                                        _blocDsQuisioner
                                            .changeComboFrekuensi(item);
                                      });
                                    },
                                    value: item.getCurrentFrekuensi(),
                                    isExpanded: false,
                                    hint: const LabelBlack.size2(
                                        'Pilih Frekuensi pembelian'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          _spasi(),
                          _textFieldNumberOnly(
                              'Berapa GB kebutuhan Quota 1 bulan',
                              _quotaController),
                          _spasi(),
                          _textFieldNumberOnly(
                              'Berapa Rupiah kebutuhan Pulsa 1 bulan',
                              _rpController),
                          const SizedBox(
                            height: 10,
                          ),
                          ButtonStrectWidth(
                            isenable: true,
                            text: 'Submit',
                            onTap: () {
                              _handleButtonSubmit(item);
                            },
                            buttonColor: Colors.red,
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
                    ),
                  ),
                );

              case EnumStateWidget.failed:
                return const CustomScaffold(
                  title: 'Market Audit',
                  body: LabelBlack.size1("Terjadi kesalahan."),
                );
            }
          }
        });
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
          const Divider(),
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

  Widget _spasi() {
    return const SizedBox(
      height: 16,
    );
  }

  void _handleButtonSubmit(ModelUiQuisioner item) {
    item.setQuesioner(
        nama: _namaController.text,
        msisdnnelpon: _nelponController.text,
        msisdninternet: _internetController.text,
        msisdndigital: _gamesController.text,
        kuotaperbulan: _quotaController.text,
        pulsaperbulan: _rpController.text);
    if (item.isQuisionerValidToSubmit()) {
      _showDialogPilihan();
    } else {
      TgzDialog.generalDialogConfirm(context, "Semua field wajib di isi");
    }
  }

  _showDialogPilihan() {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => SimpleDialog(
              title: const Text('Confirm'),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: LabelApp.size2('Anda yakin akan meng-submit data ?'),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0, left: 16.0, bottom: 3.0),
                  child: ButtonApp.black('Submit', () {
                    TgzDialog.loadingDialog(context);
                    _blocDsQuisioner.submit().then((value) {
                      if (value) {
                        _clockOutMarketAuditDS();
                      } else {
                        Navigator.of(context).pop();
                      }
                    });
                    Navigator.of(context).pop();
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0, left: 16.0, bottom: 3.0),
                  child: ButtonApp.black('CANCEL', () {
                    Navigator.of(context).pop();
                  }),
                ),
              ],
            ));
  }

  void _clockOutMarketAuditDS() {
    HttpDashboard httpDashboard = HttpDashboard();
    httpDashboard.finishMenu(EnumTab.marketaudit).then((value) {
      Navigator.of(context).pop();
      if (value.issuccess) {
        Navigator.of(context).pop();
      } else {
        if (value.message == null) {
          TgzDialog.generalDialogConfirm(context,
              'untuk dapat mengakhiri proses Market Audit,Seluruh tab harus di isi minimal dengan angka 0.');
        } else {
          TgzDialog.generalDialogConfirm(context, value.message);
        }
      }
    });
  }
}
