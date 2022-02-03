import 'package:flutter/material.dart';
import 'package:hero/core/presentation/camera/video/core_video_record.dart';
import 'package:hero/module_mt/presentation/common/voice_of_reseller/vos_video_viewer.dart';
import 'package:hero/util/uiutil.dart';
import 'package:path/path.dart';

class VOSRecordVideo extends StatefulWidget {
  const VOSRecordVideo({Key? key}) : super(key: key);

  @override
  State<VOSRecordVideo> createState() => _VOSRecordVideoState();
}

class _VOSRecordVideoState extends State<VOSRecordVideo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CoreRecordVideo(
        onStop: onStopVideo,
        maxDurationInSecon: 5,
        isStopButtonShowing: true,
      ),
    );
  }

  void push(BuildContext context, String pathVideo) {
    CommonUi()
        .openPage(this.context, VOSVideoViewer(pathVideo: pathVideo))
        .then((value) {
      if (value != null) {
        Navigator.pop(context, pathVideo);
      }
    });
  }

  void onStopVideo(String? pathVideo) {
    push(this.context, pathVideo!);
  }
}
