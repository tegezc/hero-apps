import 'package:flutter/material.dart';
import 'package:hero/model/enumapp.dart';
import 'package:hero/util/component/component_button.dart';
import 'package:hero/util/component/component_label.dart';
import 'package:hero/util/component/component_textfield.dart';
import 'package:hero/util/component/component_widget.dart';
import 'package:hero/util/constapp/consstring.dart';
import 'package:hero/util/loadingpage/loadingview.dart';

import 'bloc/blocpoi.dart';
import 'widgetforlocation.dart';

class EditorPOI extends StatefulWidget {
  static const routeName = '/editorpoi';
  final String? idpoi;
  EditorPOI(this.idpoi);
  @override
  _EditorPOIState createState() => _EditorPOIState();
}

class _EditorPOIState extends State<EditorPOI> {
  String? _title;
  String? _textBtn;
  final GlobalKey<FormState> _formKeyValue = new GlobalKey<FormState>();

  //Texteditcontroller
  TextEditingController _clatitude = new TextEditingController();
  TextEditingController _clongitude = new TextEditingController();

  TextEditingController _cnama = new TextEditingController();
  TextEditingController _calamat = new TextEditingController();
  late BlocPoi _blocPoi;
  int _counterBuild = 0;
  EnumEditorState? _enumEditorState;

  @override
  void initState() {
    _title = widget.idpoi == null ? 'Tambah POI' : 'Edit POI';
    _textBtn = widget.idpoi == null ? 'Submit' : 'Save';
    if (widget.idpoi == null) {
      _enumEditorState = EnumEditorState.baru;
    } else {
      _enumEditorState = EnumEditorState.edit;
    }
    _blocPoi = BlocPoi();
    _counterBuild = 0;

    super.initState();
  }

  void _setupvalue(UIPoi uiPoi) {
    _clongitude.text = '${uiPoi.poi.long}';
    _clatitude.text = '${uiPoi.poi.lat}';
    _cnama.text = uiPoi.poi.nama == null ? '' : '${uiPoi.poi.nama}';
    _calamat.text = uiPoi.poi.alamat == null ? '' : '${uiPoi.poi.alamat}';
  }

  @override
  void dispose() {
    _clatitude.dispose();
    _clongitude.dispose();
    _blocPoi.dispose();
    _cnama.dispose();
    _calamat.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_counterBuild == 0) {
      if (EnumEditorState.baru == _enumEditorState) {
        _blocPoi.firstTimeBaru();
      } else {
        _blocPoi.firstTimeEdit(widget.idpoi);
      }

      _counterBuild++;
    }
    return StreamBuilder<UIPoi?>(
        stream: _blocPoi.uipoi,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return ScaffoldLocation(
              title: 'Loading...',
              textBtn: '',
              onTap: () {},
              body: Container(),
            );
          }
          _clongitude.text = '${snapshot.data!.poi.long}';
          _clatitude.text = '${snapshot.data!.poi.lat}';

          bool isloading = false;
          if (snapshot.data!.enumStateWidget == EnumStateWidget.loading) {
            isloading = true;
          }

          _setupvalue(snapshot.data!);
          return Stack(
            children: [
              ScaffoldLocation(
                title: _title,
                textBtn: _textBtn,
                onTap: () {
                  FocusScope.of(context).unfocus();
                  if (!_blocPoi.isValid()) {
                    _confirmValidasi();
                  } else {
                    if (EnumEditorState.baru == _enumEditorState) {
                      _blocPoi.savePoi().then((value) {
                        if (value) {
                          _confirmSuccessSimpan();
                        } else {
                          _confirmGagalMenyimpan();
                        }
                      });
                    } else {
                      _blocPoi.updatePoi().then((value) {
                        if (value) {
                          _confirmSuccessSimpan();
                        } else {
                          _confirmGagalMenyimpan();
                        }
                      });
                    }
                  }
                },
                body: Container(
                  child: Form(
                    key: _formKeyValue,
                    autovalidateMode: AutovalidateMode.always,
                    child: new ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      children: <Widget>[
                        SizedBox(height: 20.0),
                        TextFieldNormal(
                          'Nama Poi *',
                          _cnama,
                          onChange: (str) {
                            _blocPoi.setNamaPoi(str);
                          },
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        FormAlamat(_blocPoi.controllLokasi,
                            _blocPoi.controllLokasi!.dataLokasiAlamat),
                        TextFieldNormal(
                          'Alamat (min 10 char) *',
                          _calamat,
                          onChange: (str) {
                            _blocPoi.setAlamat(str);
                          },
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        _koordinatWidget(),
                        SizedBox(
                          height: 150.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              isloading
                  ? LoadingTransparan('Sedang menyimpan...')
                  : Container(),
            ],
          );
        });
  }

  Widget _koordinatWidget() {
    return ContainerRounded(
      radius: 8.0,
      borderColor: Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextFieldNormalNumberOnly(
              'Longitude',
              _clongitude,
              enable: false,
            ),
            TextFieldNormalNumberOnly(
              'Latitude',
              _clatitude,
              enable: false,
            ),
            SizedBox(
              height: 8,
            ),
            ButtonApp.black('Update Long Lat', () {
              _blocPoi.updateLongLat();
            }),
          ],
        ),
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
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0, left: 16.0, bottom: 3.0),
                  child: LabelBlack.size2('Data POI berhasil disimpan.'),
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
              title: LabelApp.size1(
                'Confirm',
                color: Colors.red,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0, left: 16.0, bottom: 3.0),
                  child: LabelBlack.size2('Data POI gagal disimpan.'),
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

  _confirmValidasi() {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => SimpleDialog(
              title: LabelApp.size1(
                'Confirm',
                color: Colors.red,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0, left: 16.0, bottom: 3.0),
                  child: LabelBlack.size2(ConstString.failedValidasi),
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
