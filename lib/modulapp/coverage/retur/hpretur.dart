import 'package:flutter/material.dart';
import 'package:hero/model/retur.dart';
import 'package:hero/modulapp/coverage/retur/blochpretur.dart';
import 'package:hero/modulapp/coverage/retur/retureditor.dart';
import 'package:hero/util/component/component_button.dart';
import 'package:hero/util/component/component_label.dart';
import 'package:hero/util/component/component_widget.dart';

class HomePageRetur extends StatefulWidget {
  static const routeName = '/homepagerektur';

  @override
  _HomePageReturState createState() => _HomePageReturState();
}

class _HomePageReturState extends State<HomePageRetur> {
  TextEditingController _controller = new TextEditingController();
  late BlocHpRetur _blocHpRetur;
  int _counterBuild = 0;
  @override
  void initState() {
    _blocHpRetur = new BlocHpRetur();
    super.initState();
  }

  @override
  void dispose() {
    _blocHpRetur.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_counterBuild == 0) {
      _blocHpRetur.firstTime();
      _counterBuild++;
    }
    Size s = MediaQuery.of(context).size;
    double widthbtntgl = (s.width / 2) - 38;
    return StreamBuilder<UIHpRetur?>(
      stream: _blocHpRetur.uihpretur,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CustomScaffold(title: 'Loading...', body: Container());
        }
        UIHpRetur item = snapshot.data!;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(
              color: Colors.black, //change your color here
            ),
            title: Row(
              children: [
                Text(
                  'Retur',
                  style: TextStyle(color: Colors.black),
                ),
                Spacer(),
                ButtonApp.blue('+ Entry', () {
                  Navigator.pushNamed(context, ReturEditor.routeName);
                })
              ],
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Container(
              height: s.height,
              width: s.width,
              child: Column(
                children: [
                  SizedBox(
                    height: 12,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ButtonTglVer1(widthbtntgl, 'Tanggal Awal', item.tglAwal,
                            onTap: () {
                          _datePicker(true, item);
                        }),
                        SizedBox(
                          width: 8,
                        ),
                        ButtonTglVer1(
                            widthbtntgl, 'Tanggal Akhir', item.tglAkhir,
                            onTap: () {
                          _datePicker(false, item);
                        }),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: IconButton(
                              icon: Icon(
                                Icons.play_arrow_outlined,
                                size: 40,
                              ),
                              onPressed: () {
                                _controller.text = '';
                                FocusScope.of(context).unfocus();
                                _blocHpRetur.searchRangeTanggal();
                              }),
                        ),
                      ],
                    ),
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
                                hintText: "Serial number...",
                                hintStyle: new TextStyle(color: Colors.black)),
                          ),
                        ),
                        IconButton(
                            icon: Icon(Icons.search, size: 30),
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              String txt = _controller.text;
                              if (txt.length > 0) {
                                _blocHpRetur.searchBySerial(_controller.text);
                              }
                            })
                      ],
                    ),
                  ),
                  Container(
                    height: s.height - 270,
                    child: ListView.builder(
                      itemCount: item.getCountList(),
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: _controllCell(item, index),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _controllCell(UIHpRetur item, int index) {
    int tmp = item.getCountList() - 1;
    if (tmp == index) {
      if (item.isShowmoreVisible()) {
        return _btnShowMore();
      }
    }
    Retur retur = item.lretur![index];
    return _cellOutlet(retur);
  }

  Widget _btnShowMore() {
    return RaisedButton(
        child: Text('show more'),
        color: Colors.green,
        onPressed: () {
          _blocHpRetur.showMore();
        });
  }

  Widget _spasi() {
    return SizedBox(
      height: 4,
    );
  }

  Widget _cellOutlet(Retur retur) {
    String? status = retur.status;
    // if (stat == 0) {
    //   status = 'Approved';
    // } else if (stat == 1) {
    //   status = 'Rejected';
    // } else {
    //   status = 'Pending';
    // }
    //
    Color color;
    if (retur.getStatus() == EnumStatusRetur.approved) {
      color = Colors.green;
    } else if (retur.getStatus() == EnumStatusRetur.rejected) {
      color = Colors.red;
    } else {
      color = Colors.grey;
    }
    return GestureDetector(
      onTap: () {},
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
                        color: color,
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            LabelBlack.size2(retur.serial),
                            _spasi(),
                            LabelBlack.size2(
                                'Tanggal Retur: ${retur.getStrRetur()}'),
                            _spasi(),
                            LabelBlack.size2(
                                'Tanggal Approval: ${retur.getStrApproval()}'),
                            _spasi(),
                            LabelBlack.size2(status),
                          ],
                        ),
                      ),
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

  void _datePicker(bool isawal, UIHpRetur item) async {
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
        _blocHpRetur.pickComboAwal(picked);
      } else {
        _blocHpRetur.pickComboAkhir(picked);
      }
    }
  }
}
