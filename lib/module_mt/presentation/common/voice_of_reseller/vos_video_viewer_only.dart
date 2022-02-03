import 'package:flutter/material.dart';
import 'package:hero/core/presentation/camera/video/core_video_viewer_only.dart';

class VOSVideoViewerOnly extends StatelessWidget {
  final String? pathVideo;
  const VOSVideoViewerOnly({Key? key, required this.pathVideo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CoreVideoViewerOnly(pathVideo: pathVideo);
  }
}
