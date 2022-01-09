import 'package:flutter/material.dart';
import 'package:hero/http/coverage/httpdashboard.dart';
import 'package:hero/model/enumapp.dart';
import 'package:hero/model/pjp.dart';
import 'package:hero/modulapp/camera/loadingview.dart';
import 'package:hero/modulapp/coverage/marketaudit/sf/blocsurvey.dart';
import 'package:hero/modulapp/coverage/marketaudit/sf/pagebelanjasurvey.dart';
import 'package:hero/modulapp/coverage/marketaudit/sf/pagevoucher.dart';
import 'package:hero/util/component/component_button.dart';
import 'package:hero/util/component/component_label.dart';
import 'package:hero/util/component/component_widget.dart';
import 'package:hero/util/constapp/consstring.dart';

class HomeSurvey extends StatefulWidget {
  static const routeName = '/homesurvey';
  final Pjp? pjp;
  HomeSurvey(this.pjp);

  @override
  _HomeSurveyState createState() => _HomeSurveyState();
}

class _HomeSurveyState extends State<HomeSurvey> {
  int _counterBuild = 0;
  BlocSurvey? _blocSurvey;

  @override
  void initState() {
    _blocSurvey = BlocSurvey();

    super.initState();
  }

  @override
  void dispose() {
    _blocSurvey!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_counterBuild == 0) {
      _blocSurvey!.firstime(widget.pjp);
    }

    return StreamBuilder<UISurvey?>(
        stream: _blocSurvey!.uisurvey,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CustomScaffold(
              title: 'Loading...',
              body: Container(),
            );
          }
          UISurvey? item = snapshot.data;
          return DefaultTabController(
            length: 3,
            child: SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(top:12.0, bottom: 12.0),
                      child: ButtonApp.black('Selesai', () {
                        TgzDialog.loadingDialog(context);
                        HttpDashboard httpDashboard = HttpDashboard();
                        httpDashboard.finishMenu(EnumTab.survey).then((value) {
                          Navigator.of(context).pop();
                          if (value.issuccess) {
                            Navigator.of(context).pop();
                          } else {
                            if (value.message == null) {
                              TgzDialog.generalDialogConfirm(context,
                                  'untuk dapat mengakhiri proses Market Audit,Seluruh tab harus di isi minimal dengan angka 0.');
                            } else {
                              TgzDialog.generalDialogConfirm(
                                  context, value.message);
                            }
                          }
                        });
                      },bgColor: Colors.white,),
                    ),
                  ],
                  bottom: TabBar(
                    indicatorColor: Colors.white,
                    isScrollable: true,
                    tabs: [
                      // wallet share, sales broadband share, voucher fisik share
                      Tab(
                        child: LabelWhite.size2('Belanja Share'),
                      ),
                      Tab(
                        child: LabelWhite.size2('Sales Broadband Share'),
                      ),
                      Tab(
                        child: LabelWhite.size2('Voucher Internet Share'),
                      ),
                    ],
                  ),
                  backgroundColor: Colors.red[600],
                  iconTheme: IconThemeData(
                    color: Colors.white, //change your color here
                  ),
                  title: Text(
                    ConstString.textSurvey,
                    style: TextStyle(color: Colors.white),
                  ),
                  centerTitle: true,
                ),
                body: TabBarView(
                  children: [
                    PageBelanjaSurvey(item, _blocSurvey),
                    PageVoucherSurvey(item, _blocSurvey, EnumSurvey.broadband),
                    PageVoucherSurvey(item, _blocSurvey, EnumSurvey.fisik),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
