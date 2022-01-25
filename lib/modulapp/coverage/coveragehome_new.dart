import 'package:flutter/material.dart';
import 'package:hero/configuration.dart';
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
import 'package:hero/util/component/button/component_button.dart';
import 'package:hero/util/component/label/component_label.dart';
import 'package:hero/util/component/widget/horeboxdecoration.dart';
import 'package:hero/util/constapp/accountcontroller.dart';
import 'package:hero/util/filesystem/tgzfile.dart';
import 'package:hero/util/uiutil.dart';

class CoverageHome extends StatefulWidget {
  const CoverageHome({Key? key}) : super(key: key);

  @override
  _CoverageHomeState createState() => _CoverageHomeState();
}

class _CoverageHomeState extends State<CoverageHome> {
  final BlocHomePageCoverage _blocDashboard = BlocHomePageCoverage();
  int _counterBuild = 0;
  final HoreBoxDecoration _boxDecoration = HoreBoxDecoration();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _blocDashboard.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (_counterBuild == 0) {
      _blocDashboard.firstTime();
      _counterBuild++;
    }

    return StreamBuilder<UIHomeCvrg?>(
        stream: _blocDashboard.uihpcvrg,
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
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    //image: AssetImage('assets/image/coverage/BG.png'),
                    image: AssetImage('assets/image/new/BG.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                height: size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [Container()],
                ),
              ),
            ),
            Container(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 110),
                child: Column(children: [
                  const BackgroundLocationUi(),
                  SizedBox(
                      height: 50,
                      child: _account(
                          item.profile.namaSales, item.profile.namaTap)),
                  const SizedBox(height: 20),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
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
                                              const SearchLocation()));
                                } else {
                                  // CommonUi.openPage(context, SearchLocationDs());
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SearchLocationDs()));
                                }
                              },
                              child: const Image(
                                  image: AssetImage(
                                      'assets/image/feature_button/ic_cari_outlet.png'),
                                  height: 35)),
                          const SizedBox(
                            width: 3,
                          ),
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
                              child: const Image(
                                  image: AssetImage(
                                      'assets/image/feature_button/ic_tambah_outlet.png'),
                                  height: 35)),
                          GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, HomePageRetur.routeName);
                              },
                              child: const Image(
                                  image: AssetImage(
                                      'assets/image/feature_button/ic_retur.png'),
                                  height: 35)),
                        ]),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  // Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //     children: [
                  //       GestureDetector(
                  //           onTap: () {
                  //             if (item.enumAccount == EnumAccount.sf) {
                  //               Navigator.pushNamed(
                  //                   context, EditorOutlet.routeName,
                  //                   arguments: null);
                  //             } else {
                  //               _showDialogPilihTambahLokasi();
                  //             }
                  //           },
                  //           child: const Image(
                  //               image: AssetImage(
                  //                   'assets/image/feature_button/ic_extra_penjualana.png'),
                  //               height: 35)),
                  //       const SizedBox(
                  //         width: 3,
                  //       ),
                  //       GestureDetector(
                  //           onTap: () {
                  //             Navigator.pushNamed(
                  //                 context, HomePageRetur.routeName);
                  //           },
                  //           child: const Image(
                  //               image: AssetImage(
                  //                   'assets/image/feature_button/ic_retura.png'),
                  //               height: 35)),
                  //     ]),
                  Expanded(
                    child: Container(
                        padding: const EdgeInsets.only(top: 10),
                        child: _pjp(item)),
                  ),
                  const SizedBox(
                    height: 70,
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
        const SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LabelBlack.size1(nama),
            const SizedBox(
              height: 8,
            ),
            LabelBlack.size1(tap),
          ],
        ),
      ],
    );
  }

  Widget _photoAccount() {
    return const Center(
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
              title: const Text('Confirm'),
              shape: const RoundedRectangleBorder(
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
          const Spacer(),
          LabelWhite.size2(item.strJumlah),
        ],
      ),
    ));
    List<Widget> lwlist = [];
    for (var element in item.lpjp) {
      lwlist.add(_cellPjp(element));
    }
    lwlist.add(const Divider(
      color: Colors.white,
    ));
    lw.add(Expanded(
      child: Container(
        color: Colors.transparent,
        alignment: Alignment.center,
        child: ListView(
          padding: const EdgeInsets.only(top: 0),
          children: lwlist,
        ),
      ),
    ));

    lw.add(const SizedBox(
      height: 20,
    ));

    return Container(
      child: Card(
          elevation: 0,
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: lw,
          )),
      decoration:
          BoxDecoration(gradient: _boxDecoration.gradientBackgroundApp()),
    );
  }

  Widget _cellPjp(Pjp pjp) {
    Color? colorIcon;
    late Widget action;

    if (pjp.enumPjp == EnumPjp.done) {
      colorIcon = Colors.blue;
      action = LabelWhite.size3('Status: Done');
    } else if (pjp.enumPjp == EnumPjp.progress ||
        pjp.enumPjp == EnumPjp.notclockinyet) {
      String text = pjp.enumPjp == EnumPjp.progress ? "Progress" : "Clock In";
      colorIcon = Colors.white;
      action = ButtonClockInGradient(
          onTap: () {
            _handleClockin(pjp);
          },
          text: text);
    } else if (pjp.enumPjp == EnumPjp.belum) {
      colorIcon = Colors.white;
      action = const LabelWhite.size3('Not Clock In ');
    }
    String? nama = pjp.tempat!.nama;
    if (pjp.tempat!.nama!.length > 17) {
      nama = pjp.tempat!.nama!.substring(0, 17);
    }
    return Column(
      children: [
        const Divider(
          color: Colors.white,
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 8.0, right: 8.0, top: 1.0, bottom: 1.0),
          child: Row(
            children: [
              Icon(
                Icons.location_on,
                color: colorIcon,
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LabelWhite.size3(pjp.tempat!.id),
                    LabelWhite.size3(nama),
                  ],
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Center(
                    child: action,
                  )),
            ],
          ),
        ),
      ],
    );
  }

  void _handleClockin(Pjp pjp) {
    _prepareClockIn(pjp.idhistorypjp).then((value) {
      Navigator.pushNamed(context, MapClockIn.routeName, arguments: pjp)
          .then((value) {
        _blocDashboard.firstTime();
      });
    });
  }

  Future<bool> _prepareClockIn(String? idhistorypjp) async {
    // delete file
    try {
      TgzFile tgzFile = TgzFile();
      await tgzFile.deleteDirectory();
    } catch (e) {
      ph(e.toString());
    }

    //=======
    if (idhistorypjp != null) {
      await AccountHore.setIdHistoryPjp(idhistorypjp);
    } else {
      await AccountHore.setIdHistoryPjp("");
    }
    return true;
  }
}
