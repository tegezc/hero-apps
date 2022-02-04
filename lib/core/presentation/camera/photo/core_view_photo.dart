import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hero/util/component/button/component_button.dart';
import 'package:hero/util/component/label/component_label.dart';

class CorePhotoViewer extends StatefulWidget {
  static const routeName = '/corephotoviewer';
  final Function(bool) onSubmit;
  final String? pathPhoto;
  final String textSubmit;

  const CorePhotoViewer(
      {Key? key,
      required this.textSubmit,
      required this.onSubmit,
      required this.pathPhoto})
      : super(key: key);
  @override
  _CorePhotoViewerState createState() => _CorePhotoViewerState();
}

class _CorePhotoViewerState extends State<CorePhotoViewer> {
  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    if (widget.pathPhoto == null) {
      return _pageImageGagalTampil();
    } else {
      return Center(
        child: Column(
          children: [
            SizedBox(
                width: s.width,
                height: s.height - 140,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Image.file(
                    File(widget.pathPhoto!),
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: LabelBlack.title('Photo gagal ditampilkan.'),
                      );
                    },
                  ),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ButtonApp.blue(widget.textSubmit, () {
                  widget.onSubmit(true);
                }),
                ButtonApp.blue('Ambil Lagi', () {
                  Navigator.pop(context, false);
                }),
              ],
            ),
          ],
        ),
      );
    }
  }

  Widget _pageImageGagalTampil() {
    Size s = MediaQuery.of(context).size;
    return Center(
      child: Column(
        children: [
          SizedBox(
              width: s.width,
              height: s.height - 140,
              child: const Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: LabelBlack.size1("Photo gagal di tampilkan"),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ButtonApp.blue('Ambil Lagi', () {
                Navigator.of(context).pop();
              }),
            ],
          ),
        ],
      ),
    );
  }
}
