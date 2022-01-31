import 'package:flutter/material.dart';
import 'package:hero/model/enumapp.dart';
import 'package:hero/model/pjp.dart';
import 'package:hero/modulapp/coverage/merchandising/page_insert_merchandising.dart';
import 'package:hero/util/component/button/component_button.dart';
import 'package:hero/util/component/label/component_label.dart';
import 'package:hero/util/component/tgzdialog.dart';
import 'package:hero/util/component/widget/component_widget.dart';
import 'package:hero/util/constapp/accountcontroller.dart';
import 'package:hero/util/constapp/consstring.dart';

import '../../../config/configuration_sf.dart';
import 'blocmerchandising.dart';

class HomeMerchandising extends StatefulWidget {
  static const routeName = '/homemerchandising';
  final Pjp? pjp;

  const HomeMerchandising(this.pjp, {Key? key}) : super(key: key);

  @override
  _HomeMerchandisingState createState() => _HomeMerchandisingState();
}

class _HomeMerchandisingState extends State<HomeMerchandising> {
  BlocMerchandising? _blocMerchandising;
  int _counterBuild = 0;
  EnumAccount? enumAccount;
  @override
  void initState() {
    ph('idtempat pjp home merchandising: ${widget.pjp!.tempat!.id}');
    _blocMerchandising = BlocMerchandising();
    getEnumAccount().then((value) => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    _blocMerchandising!.dispose();
    super.dispose();
  }

  Future<bool> getEnumAccount() async {
    enumAccount = await AccountHore.getAccount();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    ph('masuk build');
    if (_counterBuild == 0) {
      _blocMerchandising!.firstTime(widget.pjp!);
      _counterBuild++;
    }
    return StreamBuilder<UIMerchan?>(
        stream: _blocMerchandising!.uiMerch,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CustomScaffold(title: 'Loading...', body: Container());
          }

          UIMerchan item = snapshot.data!;
          return DefaultTabController(
            length: 6,
            child: SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                      child: ButtonApp.black(
                        'Selesai',
                        () {
                          TgzDialog.showdialogSelesai(context,
                              'Apakah anda akan mengakhiri proses merchandising?',
                              () {
                            TgzDialog.loadingDialog(context);
                            _blocMerchandising!
                                .selesai(widget.pjp!)
                                .then((value) {
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                              if (value.issuccess) {
                                Navigator.of(context).pop();
                              } else {
                                if (value.message == null) {
                                  if (enumAccount == EnumAccount.sf) {
                                    TgzDialog.generalDialogConfirm(context,
                                        'untuk dapat mengakhiri proses merchandising,tab perdana,voucher fisik dan spanduk wajib diisi.');
                                  } else {
                                    TgzDialog.generalDialogConfirm(context,
                                        'untuk dapat mengakhiri proses merchandising,tab spanduk dan poster wajib diisi.');
                                  }
                                } else {
                                  TgzDialog.generalDialogConfirm(
                                      context, value.message);
                                }
                              }
                            });
                          });
                        },
                        bgColor: Colors.white,
                      ),
                    ),
                  ],
                  bottom: const TabBar(
                    indicatorColor: Colors.white,
                    isScrollable: true,
                    tabs: [
                      Tab(
                        child: LabelWhite.size2('Perdana'),
                      ),
                      Tab(
                        child: LabelWhite.size2('Voucher Fisik'),
                      ),
                      Tab(
                        child: LabelWhite.size2('Poster'),
                      ),
                      Tab(
                        child: LabelWhite.size2('Layar Toko'),
                      ),
                      Tab(
                        child: LabelWhite.size2('Papan Nama Toko'),
                      ),
                      Tab(
                        child: LabelWhite.size2('Stiker Scan QR'),
                      ),
                    ],
                  ),
                  backgroundColor: Colors.red[600],
                  iconTheme: const IconThemeData(
                    color: Colors.white, //change your color here
                  ),
                  title: Text(
                    ConstString.textMerchandising,
                    style: const TextStyle(color: Colors.white),
                  ),
                  centerTitle: true,
                ),
                body: TabBarView(
                  children: [
                    PageInsertMerchandising(EnumMerchandising.perdana,
                        item.perdana, _blocMerchandising),
                    PageInsertMerchandising(EnumMerchandising.voucherfisik,
                        item.voucherFisik, _blocMerchandising),
                    PageInsertMerchandising(EnumMerchandising.poster,
                        item.poster, _blocMerchandising),
                    PageInsertMerchandising(EnumMerchandising.spanduk,
                        item.spanduk, _blocMerchandising),
                    PageInsertMerchandising(EnumMerchandising.papan,
                        item.papanNama, _blocMerchandising),
                    PageInsertMerchandising(EnumMerchandising.stikerScanQR,
                        item.stikerScanQR, _blocMerchandising),
                  ],
                ),
              ),
            ),
          );
        });
  }

  // _loadingDialog() {
  //   showDialog<String>(
  //       context: context,
  //       builder: (BuildContext context) => SimpleDialog(
  //             title: LabelApp.size1(
  //               'Loading...',
  //               color: Colors.red,
  //             ),
  //             shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.all(Radius.circular(15.0))),
  //             children: <Widget>[
  //               LoadingBouncingLine.circle(backgroundColor: Colors.deepOrange),
  //             ],
  //           ));
  // }
}
