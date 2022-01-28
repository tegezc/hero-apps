import 'package:flutter/material.dart';
import 'package:hero/modulapp/coverage/faktur/fakturbelanjads.dart';
import 'package:hero/util/component/button/component_button.dart';
import 'package:hero/util/component/label/component_label.dart';
import 'package:hero/util/component/widget/horeboxdecoration.dart';
import 'package:hero/util/component/widget/widgetpencariankosong.dart';
import 'package:hero/util/constapp/consstring.dart';
import 'package:hero/util/uiutil.dart';

class HomePageTandemSelling extends StatelessWidget {
  const HomePageTandemSelling({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const PageTabDs();
  }
}

class PageTabDs extends StatefulWidget {
  const PageTabDs({Key? key}) : super(key: key);
  @override
  _PageTabDsState createState() => _PageTabDsState();
}

class _PageTabDsState extends State<PageTabDs> {
  final TextEditingController _controller = TextEditingController();

  late bool _isbtnfiltershow;
  int _counterBuild = 0;
  final HoreBoxDecoration _horeBoxDecoration = HoreBoxDecoration();
  @override
  void initState() {
    _isbtnfiltershow = false;

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String title = 'Tandem Selling';
    Size s = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            //image: AssetImage('assets/image/coverage/BG.png'),
            image: AssetImage('assets/image/new/BG.png'),
            fit: BoxFit.cover,
          ),
        ),
        height: s.height,
        width: s.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 8, right: 8, top: 50),
              height: s.height,
              width: s.width,
              child: Column(
                children: [
                  const SizedBox(
                    //untuk jarak atas ke tulisan judul
                    height: 30,
                  ),
                  LabelBlack.size1(title, bold: true),
                  const SizedBox(
                    height: 12,
                  ),
                  _isbtnfiltershow
                      ? SizedBox(
                          width: s.width - 12,
                          child: ButtonAppSolid('Edit Filter', onTap: () {
                            setState(() {
                              _isbtnfiltershow = false;
                            });
                          }),
                        )
                      : _serchFilter(),
                  Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              gradient:
                                  _horeBoxDecoration.gradientBackgroundApp()),
                          margin: const EdgeInsets.only(
                              top: 10.0, left: 0, right: 0),
                          padding: const EdgeInsets.all(5.0),
                          child: Card(
                            elevation: 0,
                            color: Colors.transparent,
                            child: Column(
                              children: [
                                _headerPencarian(),
                                SizedBox(
                                    height: s.height - 400,
                                    child: _controllContentPencarian()),
                                // _content(item),
                              ],
                            ),
                          ))),
                  const SizedBox(
                    height: 70,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
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

  Widget _controllContentPencarian() {
    var item = [];
    if (item.isEmpty) {
      if (_controller.text.isNotEmpty) {
        return const WidgetPencarianKosong(
            text: 'Pencarian dengan kriteria tersebut \nTIDAK DITEMUKAN.');
      } else {
        return const WidgetPencarianKosong(
            text:
                'Silahkan masukkan kata kunci \nuntuk mendapatkan hasil pencarian');
      }
    } else {
      return _content();
    }
  }

  Widget _content() {
    var coba = [];
    return ListView.builder(
      padding: const EdgeInsets.only(top: 20),
      shrinkWrap: true,
      itemCount: coba.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: _cellController(),
        );
      },
    );
  }

  Widget _spasi() {
    return const SizedBox(
      height: 4,
    );
  }

  Widget _cellController() {
    return _cellOutletDistibusi();
  }

  Widget _cellOutlet() {
    return GestureDetector(
      onTap: () {
        //_controllerTap(item);
      },
      child: Column(
        children: [
          const Divider(),
          Padding(
            padding: const EdgeInsets.only(
                left: 8.0, right: 8.0, top: 1.0, bottom: 1.0),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.playlist_add_check,
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
                          // LabelBlack.size2(item.iddigipos),
                          // _spasi(),
                          LabelBlack.size3("dfd"),
                          _spasi(),
                          LabelBlack.size3('tgl: '),
                        ],
                      ),
                    ),
                    ButtonApp.blue('View Detail', () {
                      _controllerTap();
                    }),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _cellOutletDistibusi() {
    return Column(
      children: [
        const Divider(),
        Padding(
          padding: const EdgeInsets.only(
              left: 8.0, right: 8.0, top: 1.0, bottom: 1.0),
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.playlist_add_check,
                    color: Colors.green,
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // LabelBlack.size2(item.iddigipos),
                        // _spasi(),
                        LabelBlack.size3('nama'),
                        _spasi(),
                        LabelBlack.size3('tgl: '),
                      ],
                    ),
                  ),
                  ButtonApp.blue('', () {}),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _tapNota(String? nota) {
    CommonUi().openPage(context, FakturPembayaranDs(nota, true));
  }

  void _controllerTap() {}

  Widget _serchFilter() {
    double w = MediaQuery.of(context).size.width;
    return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    icon: const Icon(
                      Icons.play_arrow_outlined,
                      size: 40,
                    ),
                    onPressed: () {
                      FocusScope.of(context).unfocus();

                      _controller.text = '';
                    }),
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 4.0, bottom: 8, right: 4, top: 8),
              child: Row(
                children: [
                  SizedBox(
                    width: w - 80,
                    child: TextField(
                      keyboardType: TextInputType.text,
                      controller: _controller,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                          ),
                          // suffixIcon:
                          //     Icon(Icons.search, color: Colors.black),
                          hintText: ConstString.hintSearchDs,
                          hintStyle: const TextStyle(color: Colors.black)),
                      onChanged: (v) {},
                    ),
                  ),
                  IconButton(
                      icon: const Icon(Icons.search, size: 30),
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                      })
                ],
              ),
            ),
          ],
        ));
  }
}
