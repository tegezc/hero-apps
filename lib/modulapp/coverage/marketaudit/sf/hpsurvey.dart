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
                    ButtonApp.blue('Selesai', () {
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
                    }),
                  ],
                  bottom: TabBar(
                    isScrollable: true,
                    tabs: [
                      // wallet share, sales broadband share, voucher fisik share
                      Tab(
                        child: LabelBlack.size2('Belanja Share'),
                      ),
                      Tab(
                        child: LabelBlack.size2('Sales Broadband Share'),
                      ),
                      Tab(
                        child: LabelBlack.size2('Voucher Internet Share'),
                      ),
                    ],
                  ),
                  backgroundColor: Colors.white,
                  iconTheme: IconThemeData(
                    color: Colors.black, //change your color here
                  ),
                  title: Text(
                    ConstString.textSurvey,
                    style: TextStyle(color: Colors.black),
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
