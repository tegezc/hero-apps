import 'package:flutter/material.dart';
import 'package:hero/util/component/label/component_label.dart';

class WidgetPencarianKosong extends StatelessWidget {
  final String text;
  const WidgetPencarianKosong({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          const Image(
              image: AssetImage('assets/image/new/ic_hore_apps2.jpg'),
              height: 60),
          const SizedBox(
            height: 10,
          ),
          LabelAppMiring.size3(text,
              textAlign: TextAlign.center, color: Colors.white),
        ],
      ),
    );
  }
}
