import 'package:flutter/material.dart';
import 'package:hero/util/component/component_button.dart';
import 'package:hero/util/component/component_label.dart';
import 'package:hero/util/component/component_widget.dart';

class PageSuccess extends StatelessWidget {
  static const String routeName = 'pagesuccess';
  final PageSuccessParam? pageSuccessParam;

  PageSuccess(this.pageSuccessParam);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: pageSuccessParam!.title,
      automaticallyImplyLeading: false,
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle_outline,
                color: Colors.green,
                size: 200,
              ),
              SizedBox(
                height: 8,
              ),
              LabelBlack.size1(pageSuccessParam!.text1),
              SizedBox(
                height: 8,
              ),
              pageSuccessParam!.text2 == null
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: LabelBlack.size1(pageSuccessParam!.text2),
                    ),
              ButtonApp.green('Lanjut ke Proses Selanjutnya', () {
                Navigator.popUntil(context,
                    ModalRoute.withName(this.pageSuccessParam!.backPage));
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class PageSuccessParam {
  final String title;
  final String text1;
  final String text2;
  final String backPage;

  PageSuccessParam(this.backPage, this.title, this.text1, this.text2);
}
