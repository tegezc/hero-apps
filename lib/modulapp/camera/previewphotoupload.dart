import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hero/http/coverage/httpdashboard.dart';
import 'package:hero/http/coverage/httpdistibusi.dart';
import 'package:hero/model/enumapp.dart';
import 'package:hero/modulapp/camera/loadingview.dart';
import 'package:hero/modulapp/camera/pagetakephoto.dart';
import 'package:hero/modulapp/coverage/clockin/clcokinclockoutcontroller.dart';
import 'package:hero/util/component/button/component_button.dart';
import 'package:hero/util/component/widget/component_widget.dart';

class PreviewPhotoWithUpload extends StatefulWidget {
  static const routeName = '/previewphotoupload';
  final ParamPreviewPhoto? param;
  PreviewPhotoWithUpload(this.param);

  @override
  _PreviewPhotoWithUploadState createState() => _PreviewPhotoWithUploadState();
}

class _PreviewPhotoWithUploadState extends State<PreviewPhotoWithUpload> {
  int _buildCount = 0;
  String? _urlImageOrNull;

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
                  ButtonApp.blue('Upload', () {
                    TgzDialog.loadingDialog(context);
                    if (widget.param!.enumTakePhoto ==
                        EnumTakePhoto.distibusiclose) {
                      _uploadPhotoAndChekOut().then((value) {
                        Navigator.of(context).pop();

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
    ClockInClockOutController clockInClockOutController =
        ClockInClockOutController();
    bool isclockin = await clockInClockOutController.clockin(
        EnumStatusTempat.close, widget.param!.pjp!);
    print("proses clockin clockout");
    print("hasil clock in: $isclockin");
    if (isclockin) {
      bool value = await _uploadPhotoDistributionIsSuccess(isClose: true);
      print("hasil upload photo: $isclockin");
      if (value) {
        bool isclockout = await clockInClockOutController.clockOut();
        print("hasil clockout : $isclockin");
        return isclockout;
      }
    }

    return false;
  }

  /// ambil photo menu distribusi sekaligus tag as finish
  Future<FinishMenu?> _uploadPhotoDistribution() async {
    bool value = await _uploadPhotoDistributionIsSuccess(isClose: false);
    if (value) {
      HttpDashboard httpDashboard = HttpDashboard();
      FinishMenu vcheckout =
          await httpDashboard.finishMenu(EnumTab.distribution);
      return vcheckout;
    }
    return null;
  }

  Future<bool> _uploadPhotoDistributionIsSuccess(
      {required bool isClose}) async {
    HttpDIstribution httpDist = HttpDIstribution();
    return await httpDist.uploadPhoto(_urlImageOrNull!, isclose: isClose);
  }
}
