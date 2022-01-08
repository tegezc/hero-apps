import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hero/model/enumapp.dart';
import 'package:hero/modulapp/camera/pagetakephoto.dart';
import 'package:hero/modulapp/camera/preferencephoto.dart';
import 'package:hero/modulapp/coverage/marketaudit/sf/hpsurvey.dart';
import 'package:hero/modulapp/coverage/merchandising/homemerchandising.dart';
import 'package:hero/util/component/component_button.dart';
import 'package:hero/util/component/component_widget.dart';

class PreviewPhoto extends StatefulWidget {
  static const routeName = '/previewphoto';
  final ParamPreviewPhoto? param;
  PreviewPhoto(this.param);
  @override
  _PreviewPhotoState createState() => _PreviewPhotoState();
}

class _PreviewPhotoState extends State<PreviewPhoto> {
  String? _urlImageOrNull;

  int _buildCount = 0;

  void _setupUrlImage() {
    if (_buildCount == 0) {
      if (widget.param != null) {
        widget.param!.getPhotoUrlOrNull().then((value) {
          _urlImageOrNull = value;
          setState(() {});
        });
        _buildCount++;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _setupUrlImage();
    Size s = MediaQuery.of(context).size;
    if (_urlImageOrNull == null) {
      return CustomScaffold(
          body: Center(
            child: Column(
              children: [
                SizedBox(
                    width: s.width,
                    height: s.height - 140,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ButtonApp.blue('Ambil Lagi', () {
                      Navigator.of(context).pop();
                    }),
                    ButtonApp.blue('Cancel', () {
                      _handleButtonCancel();
                    }),
                  ],
                ),
              ],
            ),
          ),
          title: 'Photo');
    } else {
      return CustomScaffold(
          body: Center(
            child: Column(
              children: [
                SizedBox(
                    width: s.width,
                    height: s.height - 140,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Image.file(
                        File(_urlImageOrNull!),
                      ),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ButtonApp.blue('Pakai', () {
                      switch (widget.param!.enumTakePhoto) {
                        case EnumTakePhoto.distribusi:
                          // nothing
                          break;
                        case EnumTakePhoto.distibusiclose:
                          // nothing
                          break;

                        case EnumTakePhoto.marketaudit:
                          StoredPathPhoto.setPhotoMarketAudit(_urlImageOrNull!)
                              .then((value) {
                            Navigator.popUntil(
                                context,
                                ModalRoute.withName(
                                  HomeSurvey.routeName,
                                ));
                          });
                          break;
                        case EnumTakePhoto.merchetalase:
                          print('bloc set preference');
                          StoredPathPhoto.setPhotoMerchandising(
                                  EnumMerchandising.etalase,
                                  widget.param!.enumNumber,
                                  _urlImageOrNull!)
                              .then((value) {
                            Navigator.popUntil(
                                context,
                                ModalRoute.withName(
                                  HomeMerchandising.routeName,
                                ));
                            // int counter = 0;
                            // Navigator.popUntil(context, (route) {
                            //   return counter++ == 2;
                            // });
                          });
                          break;

                        case EnumTakePhoto.merchspanduk:
                          StoredPathPhoto.setPhotoMerchandising(
                                  EnumMerchandising.spanduk,
                                  widget.param!.enumNumber,
                                  _urlImageOrNull!)
                              .then((value) {
                            Navigator.popUntil(
                                context,
                                ModalRoute.withName(
                                  HomeMerchandising.routeName,
                                ));
                          });
                          break;
                        case EnumTakePhoto.merchposter:
                          StoredPathPhoto.setPhotoMerchandising(
                                  EnumMerchandising.poster,
                                  widget.param!.enumNumber,
                                  _urlImageOrNull!)
                              .then((value) {
                            Navigator.popUntil(
                                context,
                                ModalRoute.withName(
                                  HomeMerchandising.routeName,
                                ));
                          });
                          break;
                        case EnumTakePhoto.merchpapan:
                          StoredPathPhoto.setPhotoMerchandising(
                                  EnumMerchandising.papan,
                                  widget.param!.enumNumber,
                                  _urlImageOrNull!)
                              .then((value) {
                            Navigator.popUntil(
                                context,
                                ModalRoute.withName(
                                  HomeMerchandising.routeName,
                                ));
                          });
                          break;
                        case EnumTakePhoto.merchbackdrop:
                          StoredPathPhoto.setPhotoMerchandising(
                                  EnumMerchandising.backdrop,
                                  widget.param!.enumNumber,
                                  _urlImageOrNull!)
                              .then((value) {
                            Navigator.popUntil(
                                context,
                                ModalRoute.withName(
                                  HomeMerchandising.routeName,
                                ));
                          });
                          break;
                      }
                    }),
                    ButtonApp.blue('Ambil Lagi', () {
                      Navigator.of(context).pop();
                    }),
                    ButtonApp.blue('Cancel', () {
                      _handleButtonCancel();
                    }),
                  ],
                ),
              ],
            ),
          ),
          title: 'Photo');
    }
  }

  void _handleButtonCancel() {
    switch (widget.param!.enumTakePhoto) {
      case EnumTakePhoto.distribusi:
        // nothing
        break;
      case EnumTakePhoto.distibusiclose:
        // nothing
        break;

      case EnumTakePhoto.marketaudit:
        Navigator.popUntil(
            context,
            ModalRoute.withName(
              HomeSurvey.routeName,
            ));

        break;
      case EnumTakePhoto.merchetalase:
        print('bloc set preference');

        Navigator.popUntil(
            context,
            ModalRoute.withName(
              HomeMerchandising.routeName,
            ));
        // int counter = 0;
        // Navigator.popUntil(context, (route) {
        //   return counter++ == 2;
        // });

        break;

      case EnumTakePhoto.merchspanduk:
        Navigator.popUntil(
            context,
            ModalRoute.withName(
              HomeMerchandising.routeName,
            ));

        break;
      case EnumTakePhoto.merchposter:
        Navigator.popUntil(
            context,
            ModalRoute.withName(
              HomeMerchandising.routeName,
            ));

        break;
      case EnumTakePhoto.merchpapan:
        Navigator.popUntil(
            context,
            ModalRoute.withName(
              HomeMerchandising.routeName,
            ));

        break;
      case EnumTakePhoto.merchbackdrop:
        Navigator.popUntil(
            context,
            ModalRoute.withName(
              HomeMerchandising.routeName,
            ));

        break;
    }
  }
}
