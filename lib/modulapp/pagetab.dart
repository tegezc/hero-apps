import 'package:flutter/material.dart';
import 'package:hero/model/enumapp.dart';
import 'package:hero/model/sf/itemsearchoutlet.dart';
import 'package:hero/modulapp/blocpagetabsf.dart';
import 'package:hero/modulapp/coverage/faktur/fakturbelanja.dart';
import 'package:hero/modulapp/marketaudit/sf/hphistorysurvey.dart';
import 'package:hero/modulapp/merchandising/homeviewmerchandising.dart';
import 'package:hero/modulapp/promotion/hpviewpromotion.dart';
import 'package:hero/util/component/component_button.dart';
import 'package:hero/util/component/component_label.dart';
import 'package:hero/util/constapp/consstring.dart';
import 'package:hero/util/uiutil.dart';

class PageDistribusi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageTab(EnumTab.distribution);
  }
}

class PageMerchandising extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageTab(EnumTab.merchandising);
  }
}

class PagePromotion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageTab(EnumTab.promotion);
  }
}

class PageSurvey extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageTab(EnumTab.survey);
  }
}

class PageTab extends StatefulWidget {
  final EnumTab enumTab;
  PageTab(this.enumTab);
  @override
  _PageTabState createState() => _PageTabState();
}

class _PageTabState extends State<PageTab> {
  TextEditingController _controller = new TextEditingController();

  late BlocPageTabSf _blocPageTabSf;
  int _counterBuild = 0;

  @override
  void initState() {
    _blocPageTabSf = BlocPageTabSf();
    super.initState();
  }

  @override
  void dispose() {
    _blocPageTabSf.dispose();
    _controller.dispose();
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
      _blocPageTabSf.firstTime();
      _counterBuild++;
    }

    Size s = MediaQuery.of(context).size;

    return StreamBuilder<UIPageTabSf?>(
        stream: _blocPageTabSf.uihpretur,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          UIPageTabSf item = snapshot.data!;

          return Container(
            height: s.height,
            width: s.width,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  LabelBlack.size1(title, bold: true),
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
                            _blocPageTabSf.searchRangeTanggal(widget.enumTab);
                          }),
                    ],
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: s.width - 80,
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
                                hintText: ConstString.hintSearch,
                                hintStyle: new TextStyle(color: Colors.black)),
                            onChanged: (v) {},
                          ),
                        ),
                        IconButton(
                            icon: Icon(Icons.search, size: 30),
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              _blocPageTabSf.searchByQuery(
                                  widget.enumTab, _controller.text);
                            })
                      ],
                    ),
                  ),
                  _content(item)
                ],
              ),
            ),
          );
        });
  }

  Widget _content(UIPageTabSf item) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: item.getCountList(),
      itemBuilder: (context, index) {
        return ListTile(
          title: _cellController(item, index),
        );
      },
    );
  }

  Widget _btnShowMore() {
    return RaisedButton(
        child: Text('show more'),
        color: Colors.green,
        onPressed: () {
          _blocPageTabSf.showmore(widget.enumTab);
        });
  }

  Widget _spasi() {
    return SizedBox(
      height: 4,
    );
  }

  Widget _cellController(UIPageTabSf uiPageTabSf, int index) {
    int tmp = uiPageTabSf.getCountList() - 1;
    if (tmp == index) {
      if (uiPageTabSf.isShowmoreVisible()) {
        return _btnShowMore();
      }
    }
    LokasiSearch item = uiPageTabSf.loutlet![index];
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
        color: Colors.white,
        child: Column(
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
                            LabelBlack.size2(item.namapembeli),
                            _spasi(),
                            LabelBlack.size2('tgl: ${item.getStrTgl()}'),
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
              left: 8.0, right: 8.0, top: 2.0, bottom: 2.0),
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
                        LabelBlack.size2(nama),
                        _spasi(),
                        LabelBlack.size2('tgl: ${item.getStrTgl()}'),
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
    CommonUi.openPage(context, new FakturPembayaran(nota, true));
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

  void _datePicker(bool isawal, UIPageTabSf item) async {
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
        _blocPageTabSf.pickComboAwal(picked);
      } else {
        _blocPageTabSf.pickComboAkhir(picked);
      }
    }
  }
}
