import 'package:flutter/material.dart';
import 'package:hero/model/enumapp.dart';
import 'package:hero/modulapp/coverage/location/pageidentitas.dart';
import 'package:hero/util/component/button/component_button.dart';
import 'package:hero/util/component/label/component_label.dart';
import 'package:hero/util/component/textfield/component_textfield.dart';
import 'package:hero/util/component/widget/component_widget.dart';
import 'package:hero/util/constapp/consstring.dart';
import 'package:hero/util/loadingpage/loadingview.dart';
import 'package:url_launcher/url_launcher.dart';

import 'bloc/abstractbloclokasi.dart';
import 'bloc/blocuniversitas.dart';
import 'widgetforlocation.dart';

class EditorKampus extends StatefulWidget {
  static const routeName = '/editorkampus';
  final String? iduniv;
  EditorKampus(this.iduniv);
  @override
  _EditorKampusState createState() => _EditorKampusState();
}

class _EditorKampusState extends State<EditorKampus> {
  String? _title;
  String? _textBtn;

  BlocUniversitas? _blocUniversitas;

  int _counterBuild = 0;
  EnumEditorState? _enumEditorState;

  @override
  void initState() {
    _title = widget.iduniv == null ? 'Tambah Kampus' : 'Edit Kampus';
    _textBtn = widget.iduniv == null ? 'Submit' : 'Save';
    _blocUniversitas = BlocUniversitas();
    if (widget.iduniv == null) {
      _enumEditorState = EnumEditorState.baru;
    } else {
      _enumEditorState = EnumEditorState.edit;
    }
    super.initState();
  }

  @override
  void dispose() {
    _blocUniversitas!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_counterBuild == 0) {
      if (EnumEditorState.baru == _enumEditorState) {
        _blocUniversitas!.firstTimeBaru();
      } else {
        _blocUniversitas!.firstTimeEdit(widget.iduniv);
      }
      _counterBuild++;
    }
    return StreamBuilder<UIUniv?>(
        stream: _blocUniversitas!.uiUniv,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return ScaffoldLocation(
                title: 'Loading...',
                textBtn: '',
                onTap: null,
                body: Container());
          }
          bool isloading = false;
          if (snapshot.data!.enumStateWidget == EnumStateWidget.loading) {
            isloading = true;
          }
          return Stack(
            children: [
              DefaultTabController(
                length: 3,
                child: ScaffoldLocation(
                    title: _title,
                    textBtn: _textBtn,
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      if (!_blocUniversitas!.isValid()) {
                        _confirmValidasi();
                      } else {
                        if (EnumEditorState.baru == _enumEditorState) {
                          _blocUniversitas!.saveUniv().then((value) {
                            if (value) {
                              _confirmSuccessSimpan();
                            } else {
                              _confirmGagalMenyimpan();
                            }
                          });
                        } else {
                          _blocUniversitas!.updateUniv().then((value) {
                            if (value) {
                              _confirmSuccessSimpan();
                            } else {
                              _confirmGagalMenyimpan();
                            }
                          });
                        }
                      }
                    },
                    bottom: TabBar(
                      isScrollable: true,
                      tabs: [
                        Tab(
                          child: LabelBlack.size2('Data Kampus'),
                        ),
                        Tab(
                          child: LabelBlack.size2('Rektor Kampus'),
                        ),
                        Tab(
                          child: LabelBlack.size2('PIC'),
                        ),
                      ],
                    ),
                    body: TabBarView(
                      children: [
                        TabDataKampus(_blocUniversitas,
                            _blocUniversitas!.controllLokasi!.dataLokasiAlamat),
                        PageIdentitas(
                          EnumPicOwner.owner,
                          controllOwner: _blocUniversitas!.controllOwner,
                        ),
                        PageIdentitas(
                          EnumPicOwner.pic,
                          controllPic: _blocUniversitas!.controllPic,
                        ),
                      ],
                    )),
              ),
              isloading
                  ? LoadingTransparan('Sedang menyimpan...')
                  : Container(),
            ],
          );
        });
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
                  child: LabelBlack.size2('Data kampus berhasil disimpan.'),
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
                  child: LabelBlack.size2('Data kampus gagal disimpan.'),
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

class TabDataKampus extends StatefulWidget {
  final BlocUniversitas? blocUniversitas;
  final DataLokasiAlamat? dataLokasiAlamat;

  TabDataKampus(this.blocUniversitas, this.dataLokasiAlamat);

  @override
  _TabDataKampusState createState() => _TabDataKampusState();
}

class _TabDataKampusState extends State<TabDataKampus> {
  final GlobalKey<FormState> _formKeyValue = new GlobalKey<FormState>();

  //Texteditcontroller
  TextEditingController _cnama = new TextEditingController();
  TextEditingController _cnpsn = new TextEditingController();
  TextEditingController _calamat = new TextEditingController();
  TextEditingController _clatitude = new TextEditingController();
  TextEditingController _clongitude = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void _setupvalue(UIUniv item) {
    _clongitude.text = '${item.univ.long}';
    _clatitude.text = '${item.univ.lat}';
    _cnama.text = item.univ.nama == null ? '' : '${item.univ.nama}';
    _cnpsn.text = item.univ.npsn == null ? '' : '${item.univ.npsn}';
    _calamat.text = item.univ.alamat == null ? '' : '${item.univ.alamat}';
  }

  @override
  void dispose() {
    _cnama.dispose();
    _cnpsn.dispose();
    _calamat.dispose();
    _clongitude.dispose();
    _clatitude.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UIUniv item = widget.blocUniversitas!.getUiUniv()!;
    this._setupvalue(item);

    return Container(
      child: Form(
        key: _formKeyValue,
        autovalidateMode: AutovalidateMode.always,
        child: new ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          children: <Widget>[
            SizedBox(height: 20.0),
            _npsn(),
            TextFieldNormal(
              'Nama Universitas *',
              _cnama,
              onChange: (str) {
                widget.blocUniversitas!.setNamaUniv(str);
              },
            ),
            _spasi(),
            FormAlamat(widget.blocUniversitas!.controllLokasi,
                widget.dataLokasiAlamat),
            TextFieldNormal(
              'Alamat (min 10 char) *',
              _calamat,
              onChange: (str) {
                widget.blocUniversitas!.setAlamat(str);
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
    );
  }

  Widget _spasi() {
    return SizedBox(
      height: 8,
    );
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
            ButtonApp.black('Update Long Lat', () {}),
          ],
        ),
      ),
    );
  }

  Widget _npsn() {
    return ContainerRounded(
      borderColor: Colors.black,
      radius: 8,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextFieldNormal(
              'NPSN * ',
              _cnpsn,
              onChange: (str) {
                widget.blocUniversitas!.setNpsn(str);
              },
            ),
            SizedBox(
              height: 8,
            ),
            GestureDetector(
                onTap: () {
                  this._launchURL();
                },
                child: LabelAppMiring.size2(
                  'Cek NPSN',
                  color: Colors.blue,
                )),
          ],
        ),
      ),
    );
  }

  _launchURL() async {
    const url = 'https://referensi.data.kemdikbud.go.id/index11.php';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }
}
