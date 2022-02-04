import 'package:flutter/material.dart';
import 'package:hero/model/enumapp.dart';
import 'package:hero/modulapp/coverage/location/editoroutlet.dart';
import 'package:hero/modulapp/coverage/location/view/viewoutlet.dart';
import 'package:hero/util/component/button/component_button.dart';
import 'package:hero/util/component/label/component_label.dart';
import 'package:hero/util/component/widget/horeboxdecoration.dart';
import 'package:hero/util/component/widget/component_widget.dart';
import 'package:hero/util/component/widget/widgetpencariankosong.dart';
import 'package:hero/util/constapp/consstring.dart';
import 'package:loading_animations/loading_animations.dart';

import 'blocsearchlocation.dart';
import 'hostorypjp.dart';

class SearchLocation extends StatefulWidget {
  const SearchLocation({Key? key}) : super(key: key);

  @override
  _SearchLocationState createState() => _SearchLocationState();
}

class _SearchLocationState extends State<SearchLocation> {
  final TextEditingController _controller = TextEditingController();

  late BlocSearchLocation _blocDashboard;
  int _buildCounter = 0;
  FocusNode? _focusNode;
  final HoreBoxDecoration _boxDecoration = HoreBoxDecoration();

  @override
  void initState() {
    _focusNode = FocusNode();
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
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/image/new/BG.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  children: [
                    _searchLokasi(item),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Widget _headerPencarian() {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          LabelWhite.size1("Berikut Daftar Pencarian : "),
          Divider(
            color: Colors.white,
          ),
        ],
      ),
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
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                    decoration: InputDecoration(
                        // contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                        // suffixIcon:
                        //       Icon(Icons.search, color: Colors.black),
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
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          //color: Colors.red[600],
          borderRadius: BorderRadius.circular(10.0),
          gradient: _boxDecoration.gradientBackgroundApp()),
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
    lw.add(_headerPencarian());
    if (ltempat.isEmpty) {
      if (_controller.text.isNotEmpty) {
        lw.add(WidgetPencarianKosong(
            text:
                'Tidak ada hasil pencarian untuk\nkata kunci "${_controller.text}"'));
      } else {
        lw.add(const WidgetPencarianKosong(
            text:
                'Silahkan masukkan kata kunci untuk mendapatkan hasil pencarian'));
      }
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
                  const Icon(
                    Icons.store,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LabelWhite.size3(outletSimple.idminor ?? ''),
                        LabelWhite.size3(outletSimple.text),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(),
                  // ButtonApp.blue('Edit', () {}),
                  const SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                    height: 25,
                    child: ButtonCustome(
                      text: 'PJP',
                      onTap: () {
                        // CommonUi.openPage(context, HistoryPJP(outletSimple));
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => HistoryPJP(outletSimple)));
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  SizedBox(
                    height: 25,
                    child: ButtonCustome(
                      text: 'Edit',
                      onTap: () {
                        // CommonUi.openPage(
                        //     context, EditorOutlet(outletSimple.idutama));
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) =>
                                EditorOutlet(outletSimple.idutama)));
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  SizedBox(
                    height: 25,
                    child: ButtonCustome(
                      text: 'Detail',
                      onTap: () {
                        // CommonUi.openPage(
                        //     context, ViewOutlet(outletSimple.idutama));
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) =>
                                ViewOutlet(outletSimple.idutama)));
                      },
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
    if (query.isNotEmpty) {
      _blocDashboard.searchLokasi(query, EnumJenisLokasi.outlet);
    }
  }
}
