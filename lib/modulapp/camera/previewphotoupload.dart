import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hero/http/coverage/httpdashboard.dart';
import 'package:hero/http/coverage/httpdistibusi.dart';
import 'package:hero/model/enumapp.dart';
import 'package:hero/modulapp/camera/loadingview.dart';
import 'package:hero/modulapp/camera/pagetakephoto.dart';
import 'package:hero/util/component/component_button.dart';
import 'package:hero/util/component/component_widget.dart';

class PreviewPhotoWithUpload extends StatefulWidget {
  static const routeName = '/previewphotoupload';
  final ParamPreviewPhoto? param;
  PreviewPhotoWithUpload(this.param);
  @override
  _PreviewPhotoWithUploadState createState() => _PreviewPhotoWithUploadState();
}

class _PreviewPhotoWithUploadState extends State<PreviewPhotoWithUpload> {
  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
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
                      File(widget.param!.pathPhoto!.path),
                    ),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ButtonApp.blue('Upload', () {
                    TgzDialog.loadingDialog(context);
                    if (widget.param!.enumTakePhoto ==
                        EnumTakePhoto.distibusiclose) {
                      _uploadPhotoAndChekOut().then((value) {
                        Navigator.of(context).pop();
                        print(widget.param!.enumTakePhoto);
                        if (value) {
                          Navigator.popUntil(
                              context,
                              ModalRoute.withName(
                                '/',
                              ));
                        } else {
                          TgzDialog.generalDialogConfirm(
                              context, 'Upload photo tidak berhasil.');
                        }
                      });
                    } else if (widget.param!.enumTakePhoto ==
                        EnumTakePhoto.distribusi) {
                      _uploadPhotoDistribution().then((value) {
                        Navigator.of(context).pop();
                        print(widget.param!.enumTakePhoto);
                        if (value != null) {
                          if (value.issuccess) {
                            Navigator.popUntil(
                                context,
                                ModalRoute.withName(
                                  '/menusales',
                                ));
                          } else {
                            if (value.message == null) {
                              TgzDialog.generalDialogConfirm(context,
                                  'Tidak dapat mengakhiri proses distribusi.');
                            } else {
                              TgzDialog.generalDialogConfirm(
                                  context, value.message);
                            }
                          }
                        } else {
                          TgzDialog.generalDialogConfirm(
                              context, 'Upload photo tidak berhasil.');
                        }
                      });
                    }
                  }),
                  ButtonApp.blue('Ambil Lagi', () {
                    Navigator.of(context).pop();
                  }),
                  ButtonApp.blue('Cancel', () {
                    int counter = 0;
                    Navigator.popUntil(context, (route) {
                      return counter++ == 2;
                    });
                  }),
                ],
              ),
            ],
          ),
        ),
        title: 'Photo');
  }

  /// kondisi pjp tutup
  Future<bool> _uploadPhotoAndChekOut() async {
    HttpDIstribution httpDist = HttpDIstribution();
    bool value =
        await httpDist.uploadPhoto(widget.param!.pathPhoto!.path, true);
    if (value) {
      HttpDashboard httpDashboard = HttpDashboard();
      bool vcheckout = await httpDashboard.clockout();
      return vcheckout;
    }
    return false;
  }

  /// ambil photo menu distribusi sekaligus tag as finish
  Future<FinishMenu?> _uploadPhotoDistribution() async {
    HttpDIstribution httpDist = HttpDIstribution();
    bool value =
        await httpDist.uploadPhoto(widget.param!.pathPhoto!.path, false);
    if (value) {
      HttpDashboard httpDashboard = HttpDashboard();
      FinishMenu vcheckout =
          await httpDashboard.finishMenu(EnumTab.distribution);
      return vcheckout;
    }
    return null;
  }
}
