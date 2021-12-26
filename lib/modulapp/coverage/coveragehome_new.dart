import 'package:flutter/material.dart';
import 'package:hero/model/enumapp.dart';
import 'package:hero/model/pjp.dart';
import 'package:hero/modulapp/bglocation/bglocmain.dart';
import 'package:hero/modulapp/coverage/blochomecoverage.dart';
import 'package:hero/modulapp/coverage/clockin/mapcloclin.dart';
import 'package:hero/modulapp/coverage/location/editorfakultas.dart';
import 'package:hero/modulapp/coverage/location/editoroutlet.dart';
import 'package:hero/modulapp/coverage/location/editorpoi.dart';
import 'package:hero/modulapp/coverage/location/editorsekolah.dart';
import 'package:hero/modulapp/coverage/location/editoruniversitas.dart';
import 'package:hero/modulapp/coverage/retur/hpretur.dart';
import 'package:hero/modulapp/coverage/searchlocation/locationditolak.dart';
import 'package:hero/modulapp/coverage/searchlocation/searchlocation.dart';
import 'package:hero/modulapp/coverage/searchlocation/searchlocationds.dart';
import 'package:hero/util/component/component_button.dart';
import 'package:hero/util/component/component_label.dart';
import 'package:hero/util/constapp/accountcontroller.dart';
import 'package:hero/util/uiutil.dart';

class CoverageHome extends StatefulWidget {
  @override
  _CoverageHomeState createState() => _CoverageHomeState();
}

class _CoverageHomeState extends State<CoverageHome> {
  BlocHomePageCoverage? _blocDashboard;
  int _counterBuild = 0;
  @override
  void initState() {
    _blocDashboard = BlocHomePageCoverage();
    super.initState();
  }

  @override
  void dispose() {
    _blocDashboard!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (_counterBuild == 0) {
      _blocDashboard!.firstTime();
      _counterBuild++;
    }

    return StreamBuilder<UIHomeCvrg?>(
        stream: _blocDashboard!.uihpcvrg,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }

          UIHomeCvrg item = snapshot.data!;
          if (item.enumStateWidget == EnumStateWidget.loading) {
            return LocationDitolak(_blocDashboard);
          } else if (item.enumStateWidget == EnumStateWidget.startup) {
            return Container();
          }
          return Stack(children: [
            SingleChildScrollView(
              child: Container(
                height: size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FractionallySizedBox(
                        widthFactor: 1,
                        child: Image(
                            image: AssetImage('assets/image/coverage/BG.png'))),
                  ],
                ),
              ),
            ),
            Container(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 110),
                child: Column(children: [
                  BackgroundLocationUi(),
                  SizedBox(
                      height: 50,
                      child: _account(
                          item.profile.namaSales, item.profile.namaTap)),
                  SizedBox(height: 50),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                            onTap: () {
                              if (item.enumAccount == EnumAccount.sf) {
                                // CommonUi.openPage(context, SearchLocation());
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SearchLocation()));
                              } else {
                                // CommonUi.openPage(context, SearchLocationDs());
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SearchLocationDs()));
                              }
                            },
                            child: Image(
                                image: AssetImage(
                                    'assets/image/feature_button/ic_cari_outlet.png'),
                                height: 28)),
                        GestureDetector(
                            onTap: () {
                              if (item.enumAccount == EnumAccount.sf) {
                                Navigator.pushNamed(
                                    context, EditorOutlet.routeName,
                                    arguments: null);
                              } else {
                                _showDialogPilihTambahLokasi();
                              }
                            },
                            child: Image(
                                image: AssetImage(
                                    'assets/image/feature_button/ic_tambah_outlet.png'),
                                height: 28)),
                        GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, HomePageRetur.routeName);
                            },
                            child: Image(
                                image: AssetImage(
                                    'assets/image/feature_button/ic_retur.png'),
                                height: 28)),
                      ]),
                  Container(
                    padding: const EdgeInsets.only(top:10),
                    child: _pjp(item)
                  )
                ]))
          ]);
        });
  }

  // ! Widget Profile Account
  Widget _account(String? nama, String? tap) {
    return Row(
      children: [
        _photoAccount(),
        SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LabelBlack.size1(nama),
            SizedBox(
              height: 8,
            ),
            LabelBlack.size1(tap),
          ],
        ),
      ],
    );
  }

  Widget _photoAccount() {
    return Center(
      child: Icon(
        Icons.account_circle_outlined,
        size: 50,
      ),
    );
  }

  // ! Tambah Lokasi - User DirectSales
  _showDialogPilihTambahLokasi() {
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
                  child: ButtonApp.black('Sekolah', () {
                    Navigator.of(context).pop();
                    CommonUi.openPage(context, EditorSekolah(null));
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0, left: 16.0, bottom: 3.0),
                  child: ButtonApp.black('Kampus', () {
                    Navigator.of(context).pop();
                    CommonUi.openPage(context, EditorKampus(null));
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0, left: 16.0, bottom: 3.0),
                  child: ButtonApp.black('Fakultas', () {
                    Navigator.of(context).pop();
                    CommonUi.openPage(context, EditorFakultas(null));
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0, left: 16.0, bottom: 3.0),
                  child: ButtonApp.black('POI', () {
                    Navigator.of(context).pop();
                    CommonUi.openPage(context, EditorPOI(null));
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0, left: 16.0, bottom: 3.0),
                  child: ButtonApp.black('Cancel', () {
                    Navigator.of(context).pop();
                  }),
                ),
              ],
            ));
  }

  // ! Widget Pjp
  Widget _pjp(UIHomeCvrg item) {
    List<Widget> lw = [];
    lw.add(Padding(
      padding:
          const EdgeInsets.only(top: 8.0, left: 14.0, bottom: 8.0, right: 8.0),
      child: Row(
        children: [
          LabelWhite.size2('Daftar PJP hari ${item.strTanggal}:'),
          Spacer(),
          LabelWhite.size2(item.strJumlah),
        ],
      ),
    ));

    item.lpjp.forEach((element) {
      //lw.add(_cellPjp(element.tempat.nama, element.tempat.id, element.enumPjp));
      lw.add(_cellPjp(element));
    });

    lw.add(SizedBox(
      height: 20,
    ));

    return Card(
        elevation: 2,
        color: Colors.red[600],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: lw,
        ));
  }
  Widget _cellPjp(Pjp pjp) {
    Color? colorIcon;
    late Widget action;

    if (pjp.enumPjp == EnumPjp.done) {
      colorIcon = Colors.green;
      action = LabelBlack.size2('Status: Done');
    } else if (pjp.enumPjp == EnumPjp.progress) {
      colorIcon = Colors.red;
      action = ButtonApp.red('Clock In', () {
        print("Clock In");
        Navigator.pushNamed(context, MapClockIn.routeName, arguments: pjp)
            .then((value) {
          _blocDashboard!.firstTime();
        });
      });
    } else if (pjp.enumPjp == EnumPjp.belum) {
      colorIcon = Colors.grey;
      action = LabelBlack.size2('Not Clock In ');
    }
    String? nama = pjp.tempat!.nama;
    if (pjp.tempat!.nama!.length > 17) {
      nama = pjp.tempat!.nama!.substring(0, 17);
    }
    return Column(
      children: [
        Divider(),
        Padding(
          padding: const EdgeInsets.only(
              left: 8.0, right: 8.0, top: 2.0, bottom: 2.0),
          child: Row(
            children: [
              Icon(
                Icons.location_on,
                color: colorIcon,
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LabelBlack.size2(pjp.tempat!.id),
                    LabelBlack.size2(nama),
                  ],
                ),
              ),
              Expanded(flex: 2, child: action),
            ],
          ),
        ),
      ],
    );
  }
}
