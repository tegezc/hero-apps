import 'package:flutter/material.dart';
import 'package:hero/model/enumapp.dart';
import 'package:hero/model/pjp.dart';
import 'package:hero/modulapp/camera/loadingview.dart';
import 'package:hero/modulapp/coverage/merchandising/pagemerchandising.dart';
import 'package:hero/util/component/component_button.dart';
import 'package:hero/util/component/component_label.dart';
import 'package:hero/util/component/component_widget.dart';
import 'package:hero/util/constapp/accountcontroller.dart';
import 'package:hero/util/constapp/consstring.dart';

import 'blocmerchandising.dart';

class HomeMerchandising extends StatefulWidget {
  static const routeName = '/homemerchandising';
  final Pjp? pjp;

  HomeMerchandising(this.pjp);

  @override
  _HomeMerchandisingState createState() => _HomeMerchandisingState();
}

class _HomeMerchandisingState extends State<HomeMerchandising> {
  BlocMerchandising? _blocMerchandising;
  int _counterBuild = 0;
  EnumAccount? enumAccount;
  @override
  void initState() {
    print('idtempat pjp home merchandising: ${widget.pjp!.tempat!.id}');
    _blocMerchandising = BlocMerchandising();
    getEnumAccount().then((value)=> setState((){}));
    super.initState();
  }

  @override
  void dispose() {
    _blocMerchandising!.dispose();
    super.dispose();
  }

  Future<bool> getEnumAccount() async{
    enumAccount = await AccountHore.getAccount();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    print('masuk build');
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
            length: 5,
            child: SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  actions: [
                    ButtonApp.blue('Selesai', () {
                      TgzDialog.showdialogSelesai(context,
                          'Apakah anda akan mengakhiri proses merchandising?',
                          () {
                        TgzDialog.loadingDialog(context);
                        _blocMerchandising!.selesai(widget.pjp!).then((value) {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                          if (value.issuccess) {
                            Navigator.of(context).pop();
                          } else {
                            if (value.message == null) {
                              if (enumAccount == EnumAccount.sf) {
                                TgzDialog.generalDialogConfirm(context,
                                    'untuk dapat mengakhiri proses merchandising,tab etalase dan spanduk wajib diisi.');
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
                    }),
                  ],
                  bottom: TabBar(
                    isScrollable: true,
                    tabs: [
                      Tab(
                        child: LabelBlack.size2('Etalase'),
                      ),
                      Tab(
                        child: LabelBlack.size2('Spanduk'),
                      ),
                      Tab(
                        child: LabelBlack.size2('Poster'),
                      ),
                      Tab(
                        child: LabelBlack.size2('Papan Nama Toko'),
                      ),
                      Tab(
                        child: LabelBlack.size2('Backdrop'),
                      ),
                    ],
                  ),
                  backgroundColor: Colors.white,
                  iconTheme: IconThemeData(
                    color: Colors.black, //change your color here
                  ),
                  title: Text(
                    ConstString.textMerchandising,
                    style: TextStyle(color: Colors.black),
                  ),
                  centerTitle: true,
                ),
                body: TabBarView(
                  children: [
                    PageMerchandising(EnumMerchandising.etalase, item.etalase,
                        _blocMerchandising),
                    PageMerchandising(EnumMerchandising.spanduk, item.spanduk,
                        _blocMerchandising),
                    PageMerchandising(EnumMerchandising.poster, item.poster,
                        _blocMerchandising),
                    PageMerchandising(EnumMerchandising.papan, item.papanNama,
                        _blocMerchandising),
                    PageMerchandising(EnumMerchandising.backdrop, item.backdrop,
                        _blocMerchandising),
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
