import 'package:flutter/material.dart';
import 'package:hero/util/component/label/component_label.dart';
import 'package:loading_animations/loading_animations.dart';

class TgzDialogLoading {
  Future<String?> loadingDialog(BuildContext context,
      {String? text = 'Loading'}) {
    return showDialog<String>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => SimpleDialog(
              title: LabelApp.size1(
                text,
                color: Colors.red,
              ),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              children: <Widget>[
                LoadingBouncingLine.circle(backgroundColor: Colors.red),
              ],
            ));
  }
}
