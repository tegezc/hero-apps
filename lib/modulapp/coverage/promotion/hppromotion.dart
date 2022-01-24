import 'package:flutter/material.dart';
import 'package:hero/http/coverage/httpdashboard.dart';
import 'package:hero/model/enumapp.dart';
import 'package:hero/model/pjp.dart';
import 'package:hero/model/promotion/promotion.dart';
import 'package:hero/modulapp/camera/pagerecordvideo.dart';
import 'package:hero/modulapp/coverage/promotion/blocpromotion.dart';
import 'package:hero/util/component/button/component_button.dart';
import 'package:hero/util/component/label/component_label.dart';
import 'package:hero/util/component/tgzdialog.dart';
import 'package:hero/util/component/widget/component_widget.dart';
import 'package:hero/util/constapp/consstring.dart';

class HomePagePromotion extends StatefulWidget {
  static const String routeName = '/homepagepromotion';
  final Pjp? pjp;
  const HomePagePromotion(this.pjp, {Key? key}) : super(key: key);
  @override
  _HomePagePromotionState createState() => _HomePagePromotionState();
}

class _HomePagePromotionState extends State<HomePagePromotion> {
  late BlocPromotion _blocPromotion;
  int _counterBuild = 0;
  @override
  void initState() {
    _blocPromotion = BlocPromotion();
    super.initState();
  }

  @override
  void dispose() {
    _blocPromotion.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (_counterBuild == 0) {
      _blocPromotion.reloadDataFromInternet(widget.pjp);
      _counterBuild++;
    }

    return StreamBuilder<UIPromotion?>(
        stream: _blocPromotion.uiProm,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CustomScaffold(body: Container(), title: 'Loading...');
          }

          UIPromotion item = snapshot.data!;
          return CustomScaffoldWithAction(
            title: ConstString.textPromotion,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    width: size.width,
                    height: size.height - 123,
                    child: SingleChildScrollView(
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 12,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: LabelBlack.size1('Jenis Promosi'),
                            ),
                            _content(item, size.width),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            action: Padding(
              padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
              child: ButtonApp.black(
                'Selesai',
                () {
                  TgzDialog.showdialogSelesai(context,
                      'Apakah anda yakin akan mengakhiri proses promotion?',
                      () {
                    _selesai(item);
                  });
                },
                bgColor: Colors.white,
              ),
            ),
          );
        });
  }

  void _selesai(UIPromotion item) {
    /// aturan selesai minimal melakukan sekali promotion
    /// dan maksimal 3 promotion
    if (item.jmlfinish > 0) {
      TgzDialog.loadingDialog(context);
      HttpDashboard httpDashboard = HttpDashboard();
      httpDashboard.finishMenu(EnumTab.promotion).then((value) {
        if (value.issuccess) {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        } else {
          if (value.message == null) {
            TgzDialog.generalDialogConfirm(context,
                'Untuk dapat mengakhiri proses Promotion,Minimal harus submit satu video');
          } else {
            TgzDialog.generalDialogConfirm(context, value.message);
          }
        }
      });
    } else {
      TgzDialog.generalDialogConfirm(context,
          'Untuk dapat mengakhiri proses Promotion,Minimal harus submit satu video');
    }
  }

  Widget _content(UIPromotion item, double width) {
    List<Widget> lw = [];
    lw.add(const SizedBox(
      height: 4,
    ));
    for (var element in item.lprom!) {
      lw.add(_cell(element, width, item.jmlfinish));
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: lw,
      ),
    );
  }

  Widget _cell(Promotion item, double width, int jmlvideofinish) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: GestureDetector(
        onTap: () async {
          if (item.isVideoExist) {
            // Navigator.pushNamed(context, ViewVideoPromotion.routeName,
            //     arguments: item);
            //  CommonUi.openPage(context, ViewVideoPromotion(item));
            // CommonUi.openPage(context, ResolutionsPage(item.pathVideo));
          } else {
            if (jmlvideofinish == 3) {
              _confirmSudahCukupVideo();
            } else {
              await Navigator.pushNamed(context, PageTakeVideo.routeName,
                  arguments: item);
              _blocPromotion.reloadDataFromInternet(widget.pjp);
            }
          }
        },
        child: Card(
          color: Colors.red[600],
          child: Padding(
            padding: const EdgeInsets.only(
                left: 8.0, right: 8.0, bottom: 12.0, top: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    item.isVideoExist
                        ? const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          )
                        : const SizedBox(
                            height: 24,
                            width: 24,
                          ),
                    const SizedBox(
                      width: 4,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LabelWhite.size3("Promotion"),
                        const SizedBox(height: 4),
                        LabelWhite.size2(
                          item.nama,
                        ),
                        const SizedBox(height: 10),
                        LabelWhite.size4(
                            "Duration : ${item.isVideoExist ? 30 : 0} detik")
                      ],
                    ),
                  ],
                ),
                const Icon(Icons.videocam_rounded,
                    size: 48, color: Colors.white),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _confirmSudahCukupVideo() {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => SimpleDialog(
              title: LabelApp.size1(
                'Confirm',
                color: Colors.green,
              ),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0, left: 16.0, bottom: 3.0),
                  child: LabelBlack.size2(
                      'Maksimal promosi yang bisa di lakukan adalah 3 kali. '
                      'Klik button \'Selesai\' untuk mengakhiri proses ini.'),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0, left: 16.0, bottom: 3.0),
                  child: ButtonApp.black('Ok', () {
                    Navigator.of(context).pop();
                  }),
                ),
              ],
            ));
  }
}

class ParamHPPromotion {
  Pjp? pjp;
  bool? isneedrefresh;
}

enum EnumPromotion {
  broadband,
  combosakti,
  digital,
  voice,
  digistar,
  fisikinternet,
  fisikdigital,
  lokal
}
