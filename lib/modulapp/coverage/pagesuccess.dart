import 'package:flutter/material.dart';
import 'package:hero/util/component/button/component_button.dart';
import 'package:hero/util/component/label/component_label.dart';
import 'package:hero/util/component/widget/component_widget.dart';

class PageSuccess extends StatelessWidget {
  static const String routeName = 'pagesuccess';
  final PageSuccessParam? pageSuccessParam;

  const PageSuccess(this.pageSuccessParam, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: pageSuccessParam!.title,
      automaticallyImplyLeading: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 200,
            ),
            const SizedBox(
              height: 8,
            ),
            LabelBlack.size1(pageSuccessParam!.text1),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: LabelBlack.size1(pageSuccessParam!.text2),
            ),
            ButtonApp.green('Lanjut ke Proses Selanjutnya', () {
              Navigator.popUntil(
                  context, ModalRoute.withName(pageSuccessParam!.backPage));
            }),
          ],
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
