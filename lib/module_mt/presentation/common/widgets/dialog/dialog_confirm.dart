import 'package:flutter/material.dart';
import 'package:hero/util/component/button/component_button.dart';
import 'package:hero/util/component/label/component_label.dart';

class TgzDialogConfirm {
  Future<String?> confirmTwoButton(
      BuildContext context, String str, Function onTapOk) {
    return showDialog<String>(
        context: context,
        builder: (BuildContext context) => SimpleDialog(
              title: const LabelApp.size1(
                'Confirm',
                color: Colors.black,
              ),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0, left: 16.0, bottom: 8.0),
                  child: LabelBlack.size2(str),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0, left: 16.0, bottom: 3.0),
                  child: ButtonApp.black('Tidak', () {
                    Navigator.of(context).pop();
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0, left: 16.0, bottom: 3.0),
                  child: ButtonApp.black('Ya', onTapOk),
                ),
              ],
            ));
  }

  Future<String?> confirmOneButton(BuildContext context, String? str) {
    return showDialog<String>(
        context: context,
        builder: (BuildContext context) => SimpleDialog(
              title: const LabelApp.size1(
                'Confirm',
                color: Colors.black,
              ),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0, left: 16.0, bottom: 3.0),
                  child: LabelBlack.size2(str),
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
