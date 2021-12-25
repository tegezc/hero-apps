import 'package:flutter/material.dart';
import 'package:hero/http/coverage/httppromotion.dart';
import 'package:hero/model/promotion/promotion.dart';
import 'package:hero/model/sf/itemsearchoutlet.dart';
import 'package:hero/util/component/component_label.dart';
import 'package:hero/util/component/component_widget.dart';
import 'package:hero/util/constapp/consstring.dart';

import 'previewvideopromotion.dart';

class HomePageViewPromotion extends StatefulWidget {
  final LokasiSearch itemOutlet;
  HomePageViewPromotion(this.itemOutlet);
  @override
  _HomePageViewPromotionState createState() => _HomePageViewPromotionState();
}

class _HomePageViewPromotionState extends State<HomePageViewPromotion> {
  List<Promotion>? _lpromotion;
  bool _isloading = true;
  @override
  void initState() {
    _lpromotion = [];

    super.initState();

    _setup();
  }

  void _setup() {
    _loadDataInternet().then((value) {
      if (value) {
        setState(() {
          _isloading = false;
        });
      }
    });
  }

  Future<bool> _loadDataInternet() async {
    HttpPromotion httpPromotion = HttpPromotion();
    _lpromotion = await httpPromotion.getDetailPromotion(
        widget.itemOutlet.idoutlet,
        widget.itemOutlet.tgl,
        widget.itemOutlet.getJenisLokasi());
    if (_lpromotion != null) {
      return true;
    }
    return false;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (_isloading) {
      return CustomScaffold(body: Container(), title: 'Loading...');
    }
    return CustomScaffold(
      title: ConstString.textPromotion,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: size.width,
              height: size.height - 85,
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 12,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: LabelBlack.size1('Jenis Promosi'),
                      ),
                      _content(_lpromotion!, size.width),
                      SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _content(List<Promotion> litem, double width) {
    List<Widget> lw = [];
    lw.add(SizedBox(
      height: 4,
    ));
    litem.forEach((element) {
      if (element.isVideoExist) {
        lw.add(_cell(element, width));
      }
    });
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: lw,
      ),
    );
  }

  Widget _cell(Promotion item, double width) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: GestureDetector(
        onTap: () {
          if (item.isVideoExist) {
            //    CommonUi.openPage(context, ViewVideoPromotion(item));
            //  CommonUi.openPage(context, ResolutionsPage());
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ResolutionsPage(item)),
            );
          } else {}
        },
        child: Card(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 8.0, right: 8.0, bottom: 12.0, top: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    item.isVideoExist
                        ? Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          )
                        : SizedBox(
                            height: 24,
                            width: 24,
                          ),
                    SizedBox(
                      width: 4,
                    ),
                    LabelBlack.size2(
                      item.nama,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
