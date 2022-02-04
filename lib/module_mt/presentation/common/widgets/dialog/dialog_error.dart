import 'package:flutter/material.dart';
import 'package:hero/util/component/button/component_button.dart';
import 'package:hero/util/component/label/component_label.dart';

class TgzDialogError {
  Future<String?> warningOneButton(BuildContext context, String comment) {
    return showDialog<String>(
        context: context,
        builder: (BuildContext context) => SimpleDialog(
              title: const LabelApp.size1(
                'Confirm',
                color: Colors.red,
              ),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0, left: 16.0, bottom: 3.0),
                  child: LabelBlack.size2(comment),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0, left: 16.0, bottom: 3.0),
                  child: ButtonApp.black('Ok', () {
                    Navigator.pop(context, 'ok');
                  }),
                ),
              ],
            ));
  }

  static Future warningTwoButton(BuildContext context, String message) {
    return showDialog<String>(
        context: context,
        builder: (BuildContext context) => SimpleDialog(
              title: const LabelApp.size1(
                'Confirm',
                color: Colors.red,
              ),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0, left: 16.0, bottom: 3.0),
                  child: LabelBlack.size2(message),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0, left: 16.0, bottom: 3.0),
                  child: ButtonApp.black('Ok', () {
                    Navigator.pop(context, 'ok');
                  }),
                ),
              ],
            ));
  }
}
