import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hero/model/enumapp.dart';
import 'package:hero/model/itemui.dart';
import 'package:hero/modulapp/coverage/location/pageidentitas.dart';
import 'package:hero/util/component/button/component_button.dart';
import 'package:hero/util/component/label/component_label.dart';
import 'package:hero/util/component/textfield/component_textfield.dart';
import 'package:hero/util/component/widget/component_widget.dart';
import 'package:hero/util/constapp/consstring.dart';
import 'package:hero/util/loadingpage/loadingview.dart';

import 'bloc/abstractbloclokasi.dart';
import 'bloc/blocsekolah.dart';
import 'widgetforlocation.dart';

import 'package:url_launcher/url_launcher.dart';

class EditorSekolah extends StatefulWidget {
  static const routeName = '/editorsekolah';
  final String? idsekolah;

  EditorSekolah(this.idsekolah);

  @override
  _EditorSekolahState createState() => _EditorSekolahState();
}

class _EditorSekolahState extends State<EditorSekolah> {
  String? _title;
  String? _textBtn;

  BlocSekolah? _blocSekolah;

  int _counterBuild = 0;
  EnumEditorState? _enumEditorState;

  @override
  void initState() {
    if (widget.idsekolah == null) {
      _enumEditorState = EnumEditorState.baru;
    } else {
      _enumEditorState = EnumEditorState.edit;
    }
    _blocSekolah = BlocSekolah();
    _title = widget.idsekolah == null ? 'Tambah Sekolah' : 'Edit Sekolah';
    _textBtn = widget.idsekolah == null ? 'Submit' : 'Save';
    super.initState();
  }

  @override
  void dispose() {
    _blocSekolah!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_counterBuild == 0) {
      if (EnumEditorState.baru == _enumEditorState) {
        _blocSekolah!.firstTimeBaru();
      } else {
        _blocSekolah!.firstTimeEdit(widget.idsekolah);
      }
      _counterBuild++;
    }

    return StreamBuilder<UISekolah?>(
        stream: _blocSekolah!.uisekolah,
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
                      if (!_blocSekolah!.isValid()) {
                        _confirmValidasi();
                      } else {
                        if (EnumEditorState.baru == _enumEditorState) {
                          _blocSekolah!.saveSekolah().then((value) {
                            if (value) {
                              _confirmSuccessSimpan();
                            } else {
                              _confirmGagalMenyimpan();
                            }
                          });
                        } else {
                          _blocSekolah!.updateSekolah().then((value) {
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
                        // wallet share, sales broadband share, voucher fisik share
                        Tab(
                          child: LabelBlack.size2('Data Sekolah'),
                        ),
                        Tab(
                          child: LabelBlack.size2('Kepala Sekolah'),
                        ),
                        Tab(
                          child: LabelBlack.size2('PIC'),
                        ),
                      ],
                    ),
                    body: TabBarView(
                      children: [
                        TabDataSekolah(_blocSekolah,
                            _blocSekolah!.controllLokasi!.dataLokasiAlamat),
                        PageIdentitas(
                          EnumPicOwner.owner,
                          controllOwner: _blocSekolah!.controllOwner,
                        ),
                        PageIdentitas(
                          EnumPicOwner.pic,
                          controllPic: _blocSekolah!.controllPic,
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
                  child: LabelBlack.size2('Data sekolah berhasil disimpan.'),
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
                  child: LabelBlack.size2('Data sekolah gagal disimpan.'),
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

class TabDataSekolah extends StatefulWidget {
  final BlocSekolah? blocSekolah;
  final DataLokasiAlamat? dataLokasiAlamat;

  TabDataSekolah(this.blocSekolah, this.dataLokasiAlamat);

  @override
  _TabDataSekolahState createState() => _TabDataSekolahState();
}

class _TabDataSekolahState extends State<TabDataSekolah> {
  final GlobalKey<FormState> _formKeyValue = GlobalKey<FormState>();

  late List<JenjangSekolah> _ljenjang;

  //Texteditcontroller
  TextEditingController _cnama = TextEditingController();
  TextEditingController _calamat = TextEditingController();
  TextEditingController _cjmlguru = TextEditingController();
  TextEditingController _cnpsn = TextEditingController();
  TextEditingController _cjmlmurid = TextEditingController();
  TextEditingController _clatitude = TextEditingController();
  TextEditingController _clongitude = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void _setupvalue(UISekolah item) {
    _clongitude.text = '${item.sekolah.long}';
    _clatitude.text = '${item.sekolah.lat}';
    _cnama.text = item.sekolah.nama == null ? '' : '${item.sekolah.nama}';
    _cnpsn.text = item.sekolah.noNpsn == null ? '' : '${item.sekolah.noNpsn}';
    _calamat.text = item.sekolah.alamat == null ? '' : '${item.sekolah.alamat}';
    _cjmlguru.text =
        item.sekolah.jmlGuru == null ? '' : '${item.sekolah.jmlGuru}';
    _cjmlmurid.text =
        item.sekolah.jmlMurid == null ? '' : '${item.sekolah.jmlMurid}';

    _ljenjang = [];
    ItemUi.getJenjangSekolah().forEach((key, value) {
      _ljenjang.add(value);
    });
  }

  @override
  void dispose() {
    _calamat.dispose();
    _cnama.dispose();
    _cjmlguru.dispose();
    _cnpsn.dispose();
    _cjmlmurid.dispose();
    _clatitude.dispose();
    _clongitude.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UISekolah uiSekolah = widget.blocSekolah!.getUiSekolah()!;
    this._setupvalue(uiSekolah);
    return Container(
      child: Form(
        key: _formKeyValue,
        autovalidateMode: AutovalidateMode.always,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          children: <Widget>[
            SizedBox(height: 20.0),
            _npsn(),
            TextFieldNormal(
              'Nama Sekolah *',
              _cnama,
              onChange: (str) {
                widget.blocSekolah!.setNamaSekolah(str);
              },
            ),
            _spasi(),
            LabelAppRich.size3(
              'Jenjang Sekolah ',
              color: Colors.grey[700],
            ),
            DropdownButton(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              items: _ljenjang
                  .map((value) => DropdownMenuItem(
                        child: LabelBlack.size2(value.text),
                        value: value,
                      ))
                  .toList(),
              onChanged: (dynamic item) {
                widget.blocSekolah!.comboJenjang(item);
              },
              value: uiSekolah.currentJenjang,
              isExpanded: false,
              hint: LabelBlack.size2('Pilih Jenjang Sekolah'),
            ),
            FormAlamat(
                widget.blocSekolah!.controllLokasi, widget.dataLokasiAlamat),
            TextFieldNormal(
              'Alamat (min 10 char) *',
              _calamat,
              onChange: (str) {
                widget.blocSekolah!.setAlamat(str);
              },
            ),
            SizedBox(height: 24),
            _koordinatWidget(),
            TextFieldNormalNumberOnly(
              'Jumlah Guru',
              _cjmlguru,
              onChange: (str) {
                widget.blocSekolah!.setJJmlGuru(str);
              },
            ),
            TextFieldNormalNumberOnly(
              'Jumlah Siswa',
              _cjmlmurid,
              onChange: (str) {
                widget.blocSekolah!.setJJmlSiswa(str);
              },
            ),
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
            ButtonApp.black('Update Long Lat', () {
              widget.blocSekolah!.updateLongLat();
            }),
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
                widget.blocSekolah!.setNPSN(str);
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
    } else {}
  }
}
