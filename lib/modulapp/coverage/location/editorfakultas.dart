import 'package:flutter/material.dart';
import 'package:hero/model/enumapp.dart';
import 'package:hero/modulapp/coverage/location/pageidentitas.dart';
import 'package:hero/util/component/button/component_button.dart';
import 'package:hero/util/component/label/component_label.dart';
import 'package:hero/util/component/textfield/component_textfield.dart';
import 'package:hero/util/component/widget/component_widget.dart';
import 'package:hero/util/constapp/consstring.dart';
import 'package:hero/util/loadingpage/loadingview.dart';

import 'bloc/abstractbloclokasi.dart';
import 'bloc/blocfakultas.dart';
import 'widgetforlocation.dart';

class EditorFakultas extends StatefulWidget {
  static const routeName = '/editorfakultas';
  final String? idfakultas;
  EditorFakultas(this.idfakultas);
  @override
  _EditorFakultasState createState() => _EditorFakultasState();
}

class _EditorFakultasState extends State<EditorFakultas> {
  String? _title;
  String? _textBtn;

  BlocFakultas? _blocFakultas;

  int _counterBuild = 0;
  EnumEditorState? _enumEditorState;

  @override
  void initState() {
    if (widget.idfakultas == null) {
      _enumEditorState = EnumEditorState.baru;
    } else {
      _enumEditorState = EnumEditorState.edit;
    }
    _blocFakultas = new BlocFakultas();
    _title = widget.idfakultas == null ? 'Tambah Fakultas' : 'Edit Fakultas';
    _textBtn = widget.idfakultas == null ? 'Submit' : 'Save';
    super.initState();
  }

  @override
  void dispose() {
    _blocFakultas!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_counterBuild == 0) {
      if (EnumEditorState.baru == _enumEditorState) {
        _blocFakultas!.firstTimeBaru();
      } else {
        _blocFakultas!.firstTimeEdit(widget.idfakultas);
      }
      _counterBuild++;
    }
    return StreamBuilder<UIFakultas?>(
        stream: _blocFakultas!.uifakultas,
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
                      if (!_blocFakultas!.isValid()) {
                        _confirmValidasi();
                      } else {
                        if (EnumEditorState.baru == _enumEditorState) {
                          _blocFakultas!.saveFakultas().then((value) {
                            if (value) {
                              _confirmSuccessSimpan();
                            } else {
                              _confirmGagalMenyimpan();
                            }
                          });
                        } else {
                          _blocFakultas!.updateFakultas().then((value) {
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
                          child: LabelBlack.size2('Data Fakultas'),
                        ),
                        Tab(
                          child: LabelBlack.size2('Dekan Fakultas'),
                        ),
                        Tab(
                          child: LabelBlack.size2('PIC'),
                        ),
                      ],
                    ),
                    body: TabBarView(
                      children: [
                        TabDataFakultas(_blocFakultas,
                            _blocFakultas!.controllLokasi!.dataLokasiAlamat),
                        PageIdentitas(
                          EnumPicOwner.owner,
                          controllOwner: _blocFakultas!.controllOwner,
                        ),
                        PageIdentitas(
                          EnumPicOwner.pic,
                          controllPic: _blocFakultas!.controllPic,
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
                  child: LabelBlack.size2('Data Fakultas berhasil disimpan.'),
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
                  child: LabelBlack.size2('Data fakultas gagal disimpan.'),
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

class TabDataFakultas extends StatefulWidget {
  final BlocFakultas? blocFakultas;
  final DataLokasiAlamat? dataLokasiAlamat;
  TabDataFakultas(this.blocFakultas, this.dataLokasiAlamat);

  @override
  _TabDataFakultasState createState() => _TabDataFakultasState();
}

class _TabDataFakultasState extends State<TabDataFakultas> {
  final GlobalKey<FormState> _formKeyValue = new GlobalKey<FormState>();

  //Texteditcontroller
  TextEditingController _cnama = new TextEditingController();
  TextEditingController _calamat = new TextEditingController();
  TextEditingController _cjmlDosen = new TextEditingController();
  TextEditingController _cnpsn = new TextEditingController();
  TextEditingController _cjmlmahasiswa = new TextEditingController();
  TextEditingController _clatitude = new TextEditingController();
  TextEditingController _clongitude = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void _setupvalue(UIFakultas item) {
    _clongitude.text = '${item.fakultas.long}';
    _clatitude.text = '${item.fakultas.lat}';
    _cnama.text = item.fakultas.nama == null ? '' : '${item.fakultas.nama}';
    _calamat.text =
        item.fakultas.alamat == null ? '' : '${item.fakultas.alamat}';
    _cjmlDosen.text =
        item.fakultas.jmlDosen == null ? '' : '${item.fakultas.jmlDosen}';
    _cjmlmahasiswa.text = item.fakultas.jmlMahasiswa == null
        ? ''
        : '${item.fakultas.jmlMahasiswa}';
  }

  @override
  void dispose() {
    _calamat.dispose();
    _cnama.dispose();
    _cjmlDosen.dispose();
    _cnpsn.dispose();
    _cjmlmahasiswa.dispose();
    _clatitude.dispose();
    _clongitude.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UIFakultas uifakultas = widget.blocFakultas!.getUiFakultas()!;
    this._setupvalue(uifakultas);
    return Container(
      child: Form(
        key: _formKeyValue,
        autovalidateMode: AutovalidateMode.always,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          children: <Widget>[
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.only(left: 2.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  LabelAppRich.size3(
                    'Universitas ',
                    color: Colors.grey[700],
                  ),
                  DropdownButton(
                    items: uifakultas.luniv == null
                        ? null
                        : uifakultas.luniv!
                            .map((value) => DropdownMenuItem(
                                  child: LabelBlack.size2(value.nama),
                                  value: value,
                                ))
                            .toList(),
                    onChanged: (dynamic item) {
                      setState(() {
                        widget.blocFakultas!.comboUniv(item);
                      });
                    },
                    value: uifakultas.currentUniversitas,
                    isExpanded: false,
                    hint: LabelBlack.size2('Pilih Universitas'),
                  )
                ],
              ),
            ),
            _spasi(),
            TextFieldNormal(
              'Nama Fakultas *',
              _cnama,
              onChange: (str) {
                widget.blocFakultas!.setNamaFak(str);
              },
            ),
            _spasi(),
            FormAlamat(
                widget.blocFakultas!.controllLokasi, widget.dataLokasiAlamat),
            TextFieldNormal(
              'Alamat (min 10 char) *',
              _calamat,
              onChange: (str) {
                widget.blocFakultas!.setAlamat(str);
              },
            ),
            SizedBox(
              height: 24,
            ),
            _koordinatWidget(),
            TextFieldNormalNumberOnly(
              'Jumlah Dosen',
              _cjmlDosen,
              onChange: (str) {
                widget.blocFakultas!.setJmlDosen(str);
              },
            ),
            TextFieldNormalNumberOnly(
              'Jumlah Mahasiswa',
              _cjmlmahasiswa,
              onChange: (str) {
                widget.blocFakultas!.setJmlMahasiswa(str);
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
            ButtonApp.black('Update Long Lat', () {}),
          ],
        ),
      ),
    );
  }
}
