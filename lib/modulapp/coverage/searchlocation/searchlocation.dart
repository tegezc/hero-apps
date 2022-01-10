import 'package:flutter/material.dart';
import 'package:hero/model/enumapp.dart';
import 'package:hero/modulapp/coverage/location/editoroutlet.dart';
import 'package:hero/modulapp/coverage/location/view/viewoutlet.dart';
import 'package:hero/util/component/button/component_button.dart';
import 'package:hero/util/component/label/component_label.dart';
import 'package:hero/util/component/widget/component_widget.dart';
import 'package:hero/util/constapp/consstring.dart';
import 'package:hero/util/uiutil.dart';
import 'package:loading_animations/loading_animations.dart';

import 'blocsearchlocation.dart';
import 'hostorypjp.dart';

class SearchLocation extends StatefulWidget {
  @override
  _SearchLocationState createState() => _SearchLocationState();
}

class _SearchLocationState extends State<SearchLocation> {
  TextEditingController _controller = TextEditingController();

  late BlocSearchLocation _blocDashboard;
  int _buildCounter = 0;
  FocusNode? _focusNode;

  @override
  void initState() {
    _focusNode = new FocusNode();
    _blocDashboard = BlocSearchLocation();
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
    if (_buildCounter == 0) {
      _blocDashboard.firstTime();
      _buildCounter++;
    }
    return StreamBuilder<UISearchLocation?>(
      stream: _blocDashboard.uidashboard,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CustomScaffold(title: 'Cari Lokasi', body: Container());
        } else {
          UISearchLocation item = snapshot.data!;

          return CustomScaffold(
            title: 'Cari Lokasi',
            body: SingleChildScrollView(
              child: Column(
                children: [
                  // ButtonApp.blue('Add Outlet', () {
                  //   CommonUi.openPage(context, EditorOutlet(null));
                  // }),
                  _searchLokasi(item),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Widget _searchLokasi(UISearchLocation item) {
    double w = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.only(top: 10, left: 8, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: w - 90,
                  child: TextField(
                    focusNode: _focusNode,
                    keyboardType: TextInputType.text,
                    controller: _controller,
                    style: new TextStyle(
                      fontSize: 14,
                    ),
                    decoration: InputDecoration(
                        // contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                        // suffixIcon:
                        //     new Icon(Icons.search, color: Colors.black),
                        hintText: ConstString.hintSearch,
                        hintStyle: const TextStyle(fontSize: 14)),
                    onChanged: (v) {},
                  ),
                ),
                IconButton(
                    icon: const Icon(Icons.search, size: 30),
                    onPressed: () {
                      _prosesSearch();
                    })
              ],
            )),
        _containerSearch(item)
      ],
    );
  }

  Widget _containerSearch(UISearchLocation item) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height * 0.75,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          color: Colors.red[600], borderRadius: BorderRadius.circular(10.0)),
      child: item.isloading ? _showloading() : _hasilSearch(item.ltempat!),
    );
  }

  Widget _showloading() {
    return Center(
      child: LoadingBouncingLine.circle(backgroundColor: Colors.white),
    );
  }

  Widget _hasilSearch(List<LokasiSimple?> ltempat) {
    List<Widget> lw = [];
    if (ltempat.length == 0 && _controller.text.length > 0) {
      lw.add(_hasilKosong());
    } else {
      for (int i = 0; i < ltempat.length; i++) {
        LokasiSimple tempat = ltempat[i]!;
        lw.add(_cellOutlet(tempat));
      }
    }

    return SingleChildScrollView(
      child: Column(
        children: lw,
      ),
    );
  }

  Widget _hasilKosong() {
    return Center(
      child: LabelAppMiring.size3(
          'Tidak ada hasil pencarian untuk\nkata kunci \"${_controller.text}\"',
          textAlign: TextAlign.center,
          color: Colors.white),
    );
  }

  Widget _cellOutlet(LokasiSimple outletSimple) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
              left: 8.0, right: 8.0, top: 2.0, bottom: 2.0),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.store,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LabelWhite.size3(outletSimple.idminor == null
                            ? ''
                            : outletSimple.idminor),
                        LabelWhite.size3(outletSimple.text),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(),
                  // ButtonApp.blue('Edit', () {}),
                  SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                    height: 25,
                    child: ButtonApp.red(
                      'PJP',
                      () {
                        // CommonUi.openPage(context, HistoryPJP(outletSimple));
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => HistoryPJP(outletSimple)));
                      },
                      bgColor: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  SizedBox(
                    height: 25,
                    child: ButtonApp.red(
                      'Edit',
                      () {
                        // CommonUi.openPage(
                        //     context, EditorOutlet(outletSimple.idutama));
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) =>
                                EditorOutlet(outletSimple.idutama)));
                      },
                      bgColor: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  SizedBox(
                    height: 25,
                    child: ButtonApp.red(
                      'Detail',
                      () {
                        // CommonUi.openPage(
                        //     context, ViewOutlet(outletSimple.idutama));
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) =>
                                ViewOutlet(outletSimple.idutama)));
                      },
                      bgColor: Colors.white,
                    ),
                  ),
                ],
              ),
              Divider(color: Colors.grey[400]),
            ],
          ),
        ),
      ],
    );
  }

  void _prosesSearch() {
    _focusNode!.unfocus();
    String query = _controller.text;
    if (query.length > 0) {
      _blocDashboard.searchLokasi(query, EnumJenisLokasi.outlet);
    }
  }
}
