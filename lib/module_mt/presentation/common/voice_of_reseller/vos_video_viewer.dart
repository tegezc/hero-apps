import 'package:flutter/material.dart';
import 'package:hero/core/presentation/camera/video/core_view_video.dart';
import 'package:hero/util/component/widget/component_widget.dart';

class VOSVideoViewer extends StatefulWidget {
  final String? pathVideo;
  const VOSVideoViewer({required this.pathVideo, Key? key}) : super(key: key);

  @override
  _VOSVideoViewerState createState() => _VOSVideoViewerState();
}

class _VOSVideoViewerState extends State<VOSVideoViewer> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldMT(
        body: CoreVideoViewer(
          pathVideo: widget.pathVideo,
          textSubmitButton: 'Gunakan',
          onSubmit: (isPakai) {
            _handlePakai(isPakai);
          },
        ),
        title: 'Voice of Reseller');
  }

  void _handlePakai(bool isPakai) {
    if (isPakai) {
      Navigator.pop(context, isPakai);
    }
  }
}
