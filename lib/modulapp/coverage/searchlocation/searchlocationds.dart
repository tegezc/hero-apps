import 'package:flutter/material.dart';
import 'package:hero/model/enumapp.dart';
import 'package:hero/model/itemui.dart';
import 'package:hero/modulapp/coverage/location/editorfakultas.dart';
import 'package:hero/modulapp/coverage/location/editorpoi.dart';
import 'package:hero/modulapp/coverage/location/editorsekolah.dart';
import 'package:hero/modulapp/coverage/location/editoruniversitas.dart';
import 'package:hero/modulapp/coverage/location/view/viewfakultas.dart';
import 'package:hero/modulapp/coverage/location/view/viewkampus.dart';
import 'package:hero/modulapp/coverage/location/view/viewpoi.dart';
import 'package:hero/modulapp/coverage/location/view/viewsekolah.dart';
import 'package:hero/util/component/button/component_button.dart';
import 'package:hero/util/component/label/component_label.dart';
import 'package:hero/util/component/widget/component_widget.dart';
import 'package:hero/util/constapp/consstring.dart';
import 'package:hero/util/uiutil.dart';
import 'package:loading_animations/loading_animations.dart';

import 'blocsearchlocation.dart';
import 'hostorypjp.dart';

class SearchLocationDs extends StatefulWidget {
  @override
  _SearchLocationDsState createState() => _SearchLocationDsState();
}

class _SearchLocationDsState extends State<SearchLocationDs> {
  TextEditingController _controller = TextEditingController();

  late List<ItemComboJenisLokasi> _lcombo;
  ItemComboJenisLokasi? _currentJenisLokasi;

  late BlocSearchLocation _blocDashboard;
  late bool _isbtnfiltershow;
  int _counterBuild = 0;

  @override
  void initState() {
    _blocDashboard = BlocSearchLocation();
    _isbtnfiltershow = false;
    _lcombo = ItemUi.getcombojenislokasi();

    super.initState();
  }

  @override
  void dispose() {
    _blocDashboard.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    if (_counterBuild == 0) {
      _blocDashboard.firstTime();
      _counterBuild++;
    }
    return StreamBuilder<UISearchLocation?>(
      stream: _blocDashboard.uidashboard,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CustomScaffold(body: Container(), title: 'Cari Lokasi');
        }
        UISearchLocation item = snapshot.data!;
        return CustomScaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  _isbtnfiltershow
                      ? SizedBox(
                          width: s.width - 12,
                          child: ButtonAppSolid('Edit Filter', onTap: () {
                            setState(() {
                              _isbtnfiltershow = false;
                            });
                          }),
                        )
                      : _serchFilter(context),
                  item.isloading
                      ? _showloading()
                      : _searchLocation(item.ltempat!),
                  SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
            title: 'Cari Lokasi');
      },
    );
  }

  Widget _showloading() {
    return Center(
      child: LoadingBouncingLine.circle(backgroundColor: Colors.deepOrange),
    );
  }

  Widget _serchFilter(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(3.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0, top: 12.0),
                    child: LabelAppRich.size3(
                      'Jenis Lokasi ',
                      color: Colors.black,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: DropdownButton(
                      items: _lcombo
                          .map((value) => DropdownMenuItem(
                                child: Text(
                                  value.text,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14),
                                ),
                                value: value,
                              ))
                          .toList(),
                      onChanged: (dynamic jenislokasi) {
                        if (_currentJenisLokasi != null) {
                          if (_currentJenisLokasi != jenislokasi) {
                            _controller.text = '';
                            _blocDashboard.reset();
                          }
                        }
                        setState(() {
                          _currentJenisLokasi = jenislokasi;
                        });
                      },
                      value: _currentJenisLokasi,
                      isExpanded: false,
                      hint: LabelBlack.size2('Pilih Jenis Lokasi'),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  SizedBox(
                    width: w - 90,
                    child: new TextField(
                      keyboardType: TextInputType.text,
                      controller: _controller,
                      style: new TextStyle(
                        fontSize: 14,
                      ),
                      decoration: new InputDecoration(
                          // contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                          ),
                          // suffixIcon:
                          //     new Icon(Icons.search, color: Colors.black),
                          hintText: ConstString.hintSearchDs,
                          hintStyle: new TextStyle(fontSize: 14)),
                      onChanged: (v) {},
                    ),
                  ),
                  IconButton(
                      icon: Icon(Icons.search, size: 30),
                      onPressed: () {
                        if (_currentJenisLokasi != null) {
                          String query = _controller.text;
                          if (query.length > 0) {
                            _blocDashboard.searchLokasi(
                                query, _currentJenisLokasi!.enumJenisLokasi);
                          }
                          setState(() {
                            _isbtnfiltershow = true;
                          });
                        } else {
                          _showDialogWarning(context);
                        }
                      })
                ],
              ),
            ),
          ],
        ));
  }

  Widget _searchLocation(List<LokasiSimple?> list) {
    return Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(3.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _content(list),
        ));
  }

  List<Widget> _content(List<LokasiSimple?> litem) {
    List<Widget> lw = [];
    for (int i = 0; i < litem.length; i++) {
      LokasiSimple item = litem[i]!;
      lw.add(_cellLocation(item));
    }
    return lw;
  }

  Widget _cellLocation(LokasiSimple lok) {
    return Column(
      children: [
        Divider(),
        Padding(
          padding: const EdgeInsets.only(
              left: 8.0, right: 8.0, top: 2.0, bottom: 2.0),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.store,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // LabelBlack.size2(outletSimple.iddigipos == null
                        //     ? ''
                        //     : outletSimple.iddigipos),
                        LabelBlack.size2(lok.text),
                        lok.text2 == null
                            ? Container()
                            : LabelBlack.size3(lok.text2),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(),
                  SizedBox(
                    width: 5,
                  ),
                  ButtonApp.black('PJP', () {
                    CommonUi.openPage(context, HistoryPJP(lok));
                  }),
                  SizedBox(
                    width: 8,
                  ),
                  ButtonApp.black('Edit', () {
                    _controllEditButton(lok);
                  }),
                  SizedBox(
                    width: 8,
                  ),
                  ButtonApp.black('Detail', () {
                    _controllDetailButton(lok);
                  }),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _controllEditButton(LokasiSimple lok) {
    switch (_currentJenisLokasi!.enumJenisLokasi) {
      case EnumJenisLokasi.outlet:
        break;
      case EnumJenisLokasi.poi:
        CommonUi.openPage(context, EditorPOI(lok.idutama));
        break;
      case EnumJenisLokasi.sekolah:
        CommonUi.openPage(context, EditorSekolah(lok.idutama));
        break;
      case EnumJenisLokasi.kampus:
        CommonUi.openPage(context, EditorKampus(lok.idutama));
        break;
      case EnumJenisLokasi.fakultas:
        CommonUi.openPage(context, EditorFakultas(lok.idutama));
        break;
    }
  }

  _controllDetailButton(LokasiSimple lok) {
    switch (_currentJenisLokasi!.enumJenisLokasi) {
      case EnumJenisLokasi.outlet:
        break;
      case EnumJenisLokasi.poi:
        CommonUi.openPage(context, ViewPoi(lok.idutama));
        break;
      case EnumJenisLokasi.sekolah:
        CommonUi.openPage(context, ViewSekolah(lok.idutama));
        break;
      case EnumJenisLokasi.kampus:
        CommonUi.openPage(context, ViewKampus(lok.idutama));
        break;
      case EnumJenisLokasi.fakultas:
        CommonUi.openPage(context, ViewFakultas(lok.idutama));
        break;
    }
  }

  _showDialogWarning(BuildContext context) {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => SimpleDialog(
              title: Text('Confirm'),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0, left: 16.0, bottom: 3.0),
                  child: LabelApp.size2(
                      'Tentukan spesifik jenis lokasi terlebih dulu.'),
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
