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
          onSubmit: _handlePakaiVideo,
        ),
        title: 'Voice of Reseller');
  }

  void _handlePakai(String pathVideo) {
    Navigator.pop(context, pathVideo);
  }

  void _handlePakaiVideo(String pathVideo) {
    _handlePakai(pathVideo);
  }
}
