import 'package:flutter/material.dart';
import 'package:hero/model/enumapp.dart';
import 'package:hero/model/sf/itemsearchoutlet.dart';
import 'package:hero/modulapp/blocpagetabds.dart';
import 'package:hero/modulapp/coverage/faktur/fakturbelanjads.dart';
import 'package:hero/modulapp/marketaudit/sf/hphistorysurvey.dart';
import 'package:hero/modulapp/promotion/hpviewpromotion.dart';
import 'package:hero/util/component/button/component_button.dart';
import 'package:hero/util/component/label/component_label.dart';
import 'package:hero/util/constapp/consstring.dart';
import 'package:hero/util/uiutil.dart';

import 'merchandising/homeviewmerchandising.dart';

class PageDistribusiDs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageTabDs(EnumTab.distribution);
  }
}

class PageMerchandisingDs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageTabDs(EnumTab.merchandising);
  }
}

class PagePromotionDs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageTabDs(EnumTab.promotion);
  }
}

// class PageSurveyDs extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return PageTabDs(EnumTab.survey);
//   }
// }

class PageTabDs extends StatefulWidget {
  final EnumTab enumTab;
  PageTabDs(this.enumTab);
  @override
  _PageTabDsState createState() => _PageTabDsState();
}

class _PageTabDsState extends State<PageTabDs> {
  TextEditingController _controller = new TextEditingController();

  late BlocPageTabDs _blocPageTabDs;
  late bool _isbtnfiltershow;
  int _counterBuild = 0;
  @override
  void initState() {
    _isbtnfiltershow = false;
    _blocPageTabDs = BlocPageTabDs();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _blocPageTabDs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String? title;
    switch (widget.enumTab) {
      case EnumTab.distribution:
        title = 'Distribusi';
        break;
      case EnumTab.merchandising:
        title = 'Merchandising';
        break;
      case EnumTab.promotion:
        title = 'Promotion';
        break;
      case EnumTab.survey:
        title = 'Market Audit';
        break;
      case EnumTab.mt:
        // TODO: Handle this case.
        break;
    }

    if (_counterBuild == 0) {
      _blocPageTabDs.firstTime();
      _counterBuild++;
    }

    Size s = MediaQuery.of(context).size;
    return StreamBuilder<UIPageTabDs?>(
        stream: _blocPageTabDs.uihpretur,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          UIPageTabDs item = snapshot.data!;

          return Container(
            height: s.height,
            width: s.width,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 12,
                  ),
                  LabelBlack.size1(title, bold: true),
                  SizedBox(
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
                      : _serchFilter(item),
                  Container(
                      height: s.height - 325,
                      width: s.width,
                      child: _content(item)),
                ],
              ),
            ),
          );
        });
  }

  Widget _content(UIPageTabDs uiPageTabDs) {
    return ListView.builder(
      itemCount: uiPageTabDs.getCountList(),
      itemBuilder: (context, index) {
        return ListTile(
          title: _cellController(uiPageTabDs, index),
        );
      },
    );
  }

  Widget _btnShowMore() {
    return RaisedButton(
        child: Text('show more'),
        color: Colors.green,
        onPressed: () {
          _blocPageTabDs.showmore(widget.enumTab);
        });
  }

  Widget _spasi() {
    return SizedBox(
      height: 4,
    );
  }

  Widget _cellController(UIPageTabDs uiPageTabDs, int index) {
    int tmp = uiPageTabDs.getCountList() - 1;
    if (tmp == index) {
      if (uiPageTabDs.isShowmoreVisible()) {
        return _btnShowMore();
      }
    }
    LokasiSearch item = uiPageTabDs.loutlet![index];
    return widget.enumTab != EnumTab.distribution
        ? _cellOutlet(item)
        : _cellOutletDistibusi(item);
  }

  Widget _cellOutlet(LokasiSearch item) {
    return GestureDetector(
      onTap: () {
        //_controllerTap(item);
      },
      child: Container(
        // color: Colors.white,
        child: Column(
          children: [
            Divider(),
            Padding(
              padding: const EdgeInsets.only(
                  left: 8.0, right: 8.0, top: 1.0, bottom: 1.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.playlist_add_check,
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
                            // LabelBlack.size2(item.iddigipos),
                            // _spasi(),
                            LabelBlack.size3(item.namapembeli),
                            _spasi(),
                            LabelBlack.size3('tgl: ${item.getStrTgl()}'),
                          ],
                        ),
                      ),
                      ButtonApp.blue('View Detail', () {
                        _controllerTap(item);
                      }),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cellOutletDistibusi(LokasiSearch item) {
    String? nama = item.namapembeli;
    if (item.namapembeli!.length > 17) {
      nama = item.namapembeli!.substring(0, 17);
    }
    return Column(
      children: [
        Divider(),
        Padding(
          padding: const EdgeInsets.only(
              left: 8.0, right: 8.0, top: 1.0, bottom: 1.0),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.playlist_add_check,
                    color: Colors.green,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // LabelBlack.size2(item.iddigipos),
                        // _spasi(),
                        LabelBlack.size3(nama),
                        _spasi(),
                        LabelBlack.size3('tgl: ${item.getStrTgl()}'),
                      ],
                    ),
                  ),
                  ButtonApp.blue(item.nonota, () {
                    _tapNota(item.nonota);
                  }),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _tapNota(String? nota) {
    CommonUi.openPage(context, new FakturPembayaranDs(nota, true));
  }

  void _controllerTap(LokasiSearch item) {
    switch (widget.enumTab) {
      case EnumTab.distribution:
        break;
      case EnumTab.merchandising:
        CommonUi.openPage(context, new HomeViewMerchandising(item));

        break;
      case EnumTab.promotion:
        CommonUi.openPage(context, new HomePageViewPromotion(item));
        break;
      case EnumTab.survey:
        {
          CommonUi.openPage(context, new HomeHistorySurvey(item));
        }
        break;
      case EnumTab.mt:
        // TODO: Handle this case.
        break;
    }
  }

  void _datePicker(bool isawal, UIPageTabDs item) async {
    DateTime? dtawal = DateTime(DateTime.now().year - 5);
    DateTime dtakhir = DateTime(DateTime.now().year + 5);
    DateTime initialDt = DateTime.now();
    if (!isawal) {
      if (item.tglAwal != null) {
        dtawal = item.tglAwal;
        initialDt = dtawal!.add(new Duration(days: 1));
      }
    }
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDt,
      firstDate: dtawal,
      lastDate: dtakhir,
    );

    if (picked != null) {
      if (isawal) {
        _blocPageTabDs.pickComboAwal(picked);
      } else {
        _blocPageTabDs.pickComboAkhir(picked);
      }
    }
  }

  Widget _serchFilter(UIPageTabDs item) {
    double w = MediaQuery.of(context).size.width;
    return Container(
        // margin: const EdgeInsets.all(8.0),
        // padding: const EdgeInsets.all(3.0),
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ButtonApp.blue(item.getStrAwal(), () {
                    _datePicker(true, item);
                  }),
                ),
                ButtonApp.blue(item.getStrAkhir(), () {
                  _datePicker(false, item);
                }),
                IconButton(
                    icon: Icon(
                      Icons.play_arrow_outlined,
                      size: 40,
                    ),
                    onPressed: () {
                      FocusScope.of(context).unfocus();

                      _controller.text = '';
                      _blocPageTabDs.searchRangeTanggal(widget.enumTab);
                    }),
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 4.0, bottom: 8, right: 4, top: 8),
              child: Row(
                children: [
                  SizedBox(
                    width: w - 70,
                    child: new TextField(
                      keyboardType: TextInputType.text,
                      controller: _controller,
                      style: new TextStyle(
                        color: Colors.black,
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
                          hintStyle: new TextStyle(color: Colors.black)),
                      onChanged: (v) {},
                    ),
                  ),
                  IconButton(
                      icon: Icon(Icons.search, size: 30),
                      onPressed: () {
                        FocusScope.of(context).unfocus();

                        _blocPageTabDs.searchByQuery(
                            widget.enumTab, _controller.text);
                      })
                ],
              ),
            ),
          ],
        ));
  }
}
