import 'package:flutter/material.dart';
import 'package:hero/core/presentation/camera/photo/core_take_photo.dart';
import 'package:hero/module_mt/presentation/common/penilaian_outlet/penilaian_photo_viewer.dart';
import 'package:hero/util/uiutil.dart';

class PenilaianTakePhoto extends StatefulWidget {
  const PenilaianTakePhoto({Key? key}) : super(key: key);

  @override
  _PenilaianTakePhotoState createState() => _PenilaianTakePhotoState();
}

class _PenilaianTakePhotoState extends State<PenilaianTakePhoto> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: CoreTakePhoto(
      onSubmit: (pahtPhoto) {
        _handleOnSubmit(pahtPhoto);
      },
    ));
  }

  void _handleOnSubmit(String? pathPhoto) {
    CommonUi()
        .openPage(context, PenilaianPhotoViewer(pathPhoto: pathPhoto))
        .then((isPakai) {
      if (isPakai is bool) {
        if (isPakai) Navigator.pop(context, pathPhoto);
      }
    });
  }
}
