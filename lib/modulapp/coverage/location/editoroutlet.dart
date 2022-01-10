import 'package:flutter/material.dart';
import 'package:hero/model/enumapp.dart';
import 'package:hero/util/component/button/component_button.dart';
import 'package:hero/util/component/label/component_label.dart';
import 'package:hero/util/component/textfield/component_textfield.dart';
import 'package:hero/util/component/widget/component_widget.dart';
import 'package:hero/util/constapp/consstring.dart';
import 'package:hero/util/loadingpage/loadingview.dart';

import 'bloc/abstractbloclokasi.dart';
import 'bloc/blocoutlet.dart';
import 'pageidentitas.dart';
import 'widgetforlocation.dart';

class EditorOutlet extends StatefulWidget {
  static const routeName = '/editorOutle2';
  final String? idoutlet;

  EditorOutlet(this.idoutlet);

  @override
  _EditorOutletState createState() => _EditorOutletState();
}

class _EditorOutletState extends State<EditorOutlet> {
  String? _title;

  BlocOutlet? _blocOutlet;

  int _counterBuild = 0;
  EnumEditorState? _enumEditorState;

  @override
  void initState() {
    if (widget.idoutlet == null) {
      _enumEditorState = EnumEditorState.baru;
    } else {
      _enumEditorState = EnumEditorState.edit;
    }
    _blocOutlet = new BlocOutlet();
    _title = _enumEditorState == EnumEditorState.baru
        ? _title = 'Tambah Lokasi'
        : 'Edit Lokasi';
    super.initState();
  }

  @override
  void dispose() {
    _blocOutlet!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_counterBuild == 0) {
      if (EnumEditorState.baru == _enumEditorState) {
        _blocOutlet!.firstTimeBaru();
      } else {
        _blocOutlet!.firstTimeEdit(widget.idoutlet);
      }
      _counterBuild++;
    }
    return StreamBuilder<UIOutlet?>(
        stream: _blocOutlet!.uioutlet,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return ScaffoldLocation(
                title: 'Loading...',
                textBtn: '',
                onTap: null,
                body: Container());
          } else {
            String textSbmt = 'Submit';
            if (widget.idoutlet != null) {
              textSbmt = 'Save';
            }
            bool isloading = false;
            if (snapshot.data!.enumStateWidget == EnumStateWidget.loading) {
              isloading = true;
            }
            return Stack(children: [
              DefaultTabController(
                length: 3,
                child: ScaffoldLocation(
                    title: _title,
                    textBtn: textSbmt,
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      if (!_blocOutlet!.isValid()) {
                        _confirmValidasi();
                      } else {
                        if (EnumEditorState.baru == _enumEditorState) {
                          _blocOutlet!.saveOutlet().then((value) {
                            if (value) {
                              _confirmSuccessSimpan();
                            } else {
                              _confirmGagalMenyimpan();
                            }
                          });
                        } else {
                          _blocOutlet!.updateOutlet().then((value) {
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
                      indicatorColor: Colors.white,
                      isScrollable: true,
                      tabs: [
                        // wallet share, sales broadband share, voucher fisik share
                        Tab(
                          child: LabelWhite.size2('Data Outlet'),
                        ),
                        Tab(
                          child: LabelWhite.size2('Owner Outlet'),
                        ),
                        Tab(
                          child: LabelWhite.size2('PIC'),
                        ),
                      ],
                    ),
                    body: TabBarView(
                      children: [
                        TabDataOutlet2(_blocOutlet,
                            _blocOutlet!.controllLokasi!.dataLokasiAlamat),
                        PageIdentitas(
                          EnumPicOwner.owner,
                          controllOwner: _blocOutlet!.controllOwner,
                        ),
                        PageIdentitas(
                          EnumPicOwner.pic,
                          controllPic: _blocOutlet!.controllPic,
                        ),
                      ],
                    )),
              ),
              isloading
                  ? LoadingTransparan('Sedang menyimpan...')
                  : Container(),
            ]);
          }
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
                  child: LabelBlack.size2('Outlet berhasil disimpan.'),
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
                  child: LabelBlack.size2('Outlet gagal disimpan.'),
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

class TabDataOutlet2 extends StatefulWidget {
  final BlocOutlet? blocOutlet;
  final DataLokasiAlamat? dataLokasiAlamat;

  TabDataOutlet2(this.blocOutlet, this.dataLokasiAlamat);

  @override
  _TabDataOutlet2State createState() => _TabDataOutlet2State();
}

class _TabDataOutlet2State extends State<TabDataOutlet2> {
  final GlobalKey<FormState> _formKeyValue = new GlobalKey<FormState>();

  //Texteditcontroller
  TextEditingController _cnama = new TextEditingController();
  TextEditingController _cnors = new TextEditingController();
  TextEditingController _calamat = new TextEditingController();
  TextEditingController _clatitude = new TextEditingController();
  TextEditingController _clongitude = new TextEditingController();

  @override
  void initState() {
    // this._setupFirstime();
    super.initState();
  }

  void _setupvalue(UIOutlet item) {
    _clongitude.text = '${item.outlet.long}';
    _clatitude.text = '${item.outlet.lat}';
    _cnama.text = item.outlet.nama == null ? '' : '${item.outlet.nama}';
    _cnors.text = item.outlet.nors == null ? '' : '${item.outlet.nors}';
    _calamat.text = item.outlet.alamat == null ? '' : '${item.outlet.alamat}';
    //
    // _ljnsoutlet = new List();
    // ItemUi.getComboJenisOutlet().forEach((key, value) {
    //   _ljnsoutlet.add(value);
    // });
  }

  @override
  void dispose() {
    _cnama.dispose();
    _cnors.dispose();
    _calamat.dispose();
    _clongitude.dispose();
    _clatitude.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UIOutlet item = widget.blocOutlet!.getUiOutlet()!;
    this._setupvalue(item);
    return Container(
      child: Form(
        key: _formKeyValue,
        autovalidateMode: AutovalidateMode.always,
        child: new ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          children: <Widget>[
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.only(left: 2.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  TextFieldNormal(
                    'Nama Outlet *',
                    _cnama,
                    onChange: (str) {
                      widget.blocOutlet!.setNamaOutlet(str);
                    },
                  ),
                  TextFieldNormalNumberOnly(
                    'Nomor RS *',
                    _cnors,
                    onChange: (str) {
                      widget.blocOutlet!.setNors(str);
                    },
                  ),
                  SizedBox(height: 8),
                  LabelAppRich.size3(
                    'Jenis Outlet ',
                    color: Colors.grey[700],
                  ),
                  DropdownButton(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                    },
                    items: item.ljnsoutlet == null
                        ? null
                        : item.ljnsoutlet!
                            .map((value) => DropdownMenuItem(
                                  child: LabelBlack.size2(value.text),
                                  value: value,
                                ))
                            .toList(),
                    onChanged: (dynamic item) {
                      widget.blocOutlet!.comboJnsOutletOnChange(item);
                    },
                    value: item.currentjnsOutlet,
                    isExpanded: false,
                    hint: LabelBlack.size2('Pilih Jenis Outlet'),
                  )
                ],
              ),
            ),
            _spasi(),
            FormAlamat(
                widget.blocOutlet!.controllLokasi, widget.dataLokasiAlamat),
            TextFieldNormal(
              'Alamat (min 10 char) ',
              _calamat,
              onChange: (str) {
                widget.blocOutlet!.setAlamat(str);
              },
            ),
            SizedBox(height: 24),
            _koordinatWidget(item),
            SizedBox(
              height: 150.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget _koordinatWidget(UIOutlet item) {
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
            // item.enumEditorState == EnumEditorState.edit
            //     ? ButtonApp.black('Update Long Lat', () {
            //         widget.blocOutlet.updateLongLat();
            //       })
            //     : Container(),
            ButtonApp.black('Update Long Lat', () {
              widget.blocOutlet!.updateLongLat();
            })
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
}
