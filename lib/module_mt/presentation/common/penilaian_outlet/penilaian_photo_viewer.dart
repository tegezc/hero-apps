import 'package:flutter/material.dart';
import 'package:hero/core/presentation/camera/photo/core_view_photo.dart';

class PenilaianPhotoViewer extends StatefulWidget {
  final String? pathPhoto;
  const PenilaianPhotoViewer({Key? key, required this.pathPhoto})
      : super(key: key);

  @override
  _PenilaianPhotoViewerState createState() => _PenilaianPhotoViewerState();
}

class _PenilaianPhotoViewerState extends State<PenilaianPhotoViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CorePhotoViewer(
        textSubmit: 'Gunakan',
        onSubmit: (isPakai) {
          _handleOnSubmit(isPakai);
        },
        pathPhoto: widget.pathPhoto,
      ),
    );
  }

  void _handleOnSubmit(bool isPakai) {
    Navigator.pop(context, isPakai);
  }
}
