import 'package:flutter/material.dart';
import 'package:hero/model/serialnumber.dart';
import 'package:hero/modulapp/coverage/retur/blocretureditor.dart';
import 'package:hero/util/component/button/component_button.dart';
import 'package:hero/util/component/label/component_label.dart';
import 'package:hero/util/component/textfield/component_textfield.dart';
import 'package:hero/util/component/widget/component_widget.dart';

class ReturEditor extends StatefulWidget {
  static const routeName = '/retureditor';

  @override
  _ReturEditorState createState() => _ReturEditorState();
}

class _ReturEditorState extends State<ReturEditor> {
  final TextEditingController _textController1 = TextEditingController();
  final TextEditingController _textController2 = TextEditingController();

  late bool _isRange;
  late BlocReturEditor _blocReturEditor;
  int _counterBuild = 0;

  @override
  void initState() {
    _blocReturEditor = BlocReturEditor();
    _isRange = false;
    super.initState();
  }

  @override
  void dispose() {
    _blocReturEditor.dispose();
    _textController1.dispose();
    _textController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    if (_counterBuild == 0) {
      _blocReturEditor.firstTime();
      _counterBuild++;
    }
    return StreamBuilder<UIReturEditor?>(
        stream: _blocReturEditor.uiretureditor,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CustomScaffold(title: 'Loading...', body: Container());
          }

          UIReturEditor item = snapshot.data!;
          return CustomScaffold(
            title: 'Retur',
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        width: size.width,
                        height: size.height,
                        child: SingleChildScrollView(
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 12,
                                ),
                                _contentTransaksi(item),
                                const SizedBox(
                                  height: 12,
                                ),
                                _contentSeri(item),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: SizedBox(
                    width: size.width - 2,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                item.isSafetosubmit()
                                    ? Colors.red[600]
                                    : Colors.grey[400]),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ))),
                        child: const Text(
                          'RETUR',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: item.isSafetosubmit()
                            ? () {
                                _blocReturEditor.submitRetur().then((value) {
                                  if (value) {
                                    _confirmSuccessSimpan();
                                  } else {
                                    _confirmGagalMenyimpan();
                                  }
                                });
                              }
                            : null),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget _contentTransaksi(UIReturEditor item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const LabelApp.size2(
                        'Alasan Retur :',
                      ),
                      DropdownButton(
                        items: item.comboAlasan == null
                            ? null
                            : item.comboAlasan!
                                .map((value) => DropdownMenuItem(
                                      child: Text(
                                        value.text!,
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                      value: value,
                                    ))
                                .toList(),
                        onChanged: (dynamic selectedAccountType) {
                          _blocReturEditor.comboAlasan(selectedAccountType);
                        },
                        value: item.currentAlasan,
                        isExpanded: false,
                        hint: const Text(
                          'Pilih alasan retur',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: SizedBox(
                            width: 200,
                            child: TextFieldNumberOnly(
                                'Nomor Seri :', _textController1)),
                      ),
                      const SizedBox(height: 15),
                      _isRange
                          ? Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 8.0),
                              child: SizedBox(
                                  width: 200,
                                  child: TextFieldNumberOnly(
                                      'Nomor Seri', _textController2)),
                            )
                          : Container(),
                      const SizedBox(height: 15),
                      ButtonApp.black('SEARCH', () {
                        FocusScope.of(context).unfocus();
                        _blocReturEditor.searchSerialNumber(
                            _textController1.text, _textController2.text);
                      }),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Material(
                        type: MaterialType.circle,
                        color: Colors.red[600],
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                _isRange = !_isRange;
                              });
                            },
                            icon: Icon(
                                _isRange
                                    ? Icons.arrow_upward_rounded
                                    : Icons.arrow_downward_rounded,
                                color: Colors.white))),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _contentSeri(UIReturEditor item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 12,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const LabelBlack.size1('Serial Number'),
              LabelBlack.size1(item.getTotal()),
            ],
          ),
        ),
        _contentListSeri(item.lserial!),
      ],
    );
  }

  Widget _contentListSeri(List<SerialNumber> lseri) {
    List<Widget> lw = [];
    lw.add(const SizedBox(
      height: 4,
    ));
    for (int i = 0; i < lseri.length; i++) {
      SerialNumber item = lseri[i];
      lw.add(_cell(item, i));
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          children: lw,
        ),
      ),
    );
  }

  Widget _cell(SerialNumber seri, int index) {
    return ListTile(
      leading: Checkbox(
        onChanged: (bool? value) {
          _blocReturEditor.checkRadio(index, value!);
        },
        value: seri.ischecked,
      ),
      title: Text(seri.serial!),
    );
  }

  _confirmSuccessSimpan() {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => SimpleDialog(
              title: const LabelApp.size1(
                'Confirm',
                color: Colors.green,
              ),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              children: <Widget>[
                const Padding(
                  padding:
                      EdgeInsets.only(right: 16.0, left: 16.0, bottom: 3.0),
                  child: LabelBlack.size2('Retur berhasil di submit.'),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0, left: 16.0, bottom: 3.0),
                  child: ButtonApp.black('Ok', () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  }),
                ),
              ],
            ));
  }

  _confirmGagalMenyimpan() {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => SimpleDialog(
              title: const LabelApp.size1(
                'Confirm',
                color: Colors.red,
              ),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              children: <Widget>[
                const Padding(
                  padding:
                      EdgeInsets.only(right: 16.0, left: 16.0, bottom: 3.0),
                  child: LabelBlack.size2('Retur gagal di submit.'),
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
