import 'package:flutter/material.dart';

import '../../../../util/component/widget/widget_success_submit.dart';

class WidgetSucces extends StatelessWidget {
  const WidgetSucces({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: WidgeSuccessSubmit(),
        ),
      ],
    );
  }
}
