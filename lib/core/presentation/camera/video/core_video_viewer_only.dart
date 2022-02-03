import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hero/util/component/label/component_label.dart';
import 'package:hero/util/component/widget/component_widget.dart';
import 'package:video_player/video_player.dart';

class CoreVideoViewerOnly extends StatefulWidget {
  static const String routeName = '/pagecorevideoviewer';
  final String? pathVideo;
  const CoreVideoViewerOnly({
    Key? key,
    required this.pathVideo,
  }) : super(key: key);
  @override
  _CoreVideoViewerOnlyState createState() => _CoreVideoViewerOnlyState();
}

class _CoreVideoViewerOnlyState extends State<CoreVideoViewerOnly> {
  late VideoPlayerController _controller;
  bool _isLoading = true;
  bool _isError = false;

  int _counterBuild = 0;

  void initialVideoPlayer() {
    if (_counterBuild == 0) {
      _counterBuild++;
      if (widget.pathVideo != null) {
        try {
          _controller = VideoPlayerController.file(
            File(widget.pathVideo!),
          );

          // Initialize the controller and store the Future for later use.
          _controller.initialize().then((value) {
            setState(() {
              _isLoading = false;
            });
          });

          // Use the controller to loop the video.
          _controller.setLooping(true);
        } catch (e) {
          setState(() {
            _isError = true;
          });
        }
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    initialVideoPlayer();
    //   Size size = MediaQuery.of(context).size;
    if (_isLoading) {
      return const Center(
        child: LabelBlack.title('Mohon menunggu\nSedang mempersiapkan data.'),
      );
    }

    if (_isError) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: LabelBlack.title('File video tidak dapat di akses.'),
        ),
      );
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ContainerRounded(
                borderColor: Colors.black,
                radius: 4.0,
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  // Use the VideoPlayer widget to display the video.
                  child: VideoPlayer(_controller),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  // If the video is playing, pause it.
                  if (_controller.value.isPlaying) {
                    _controller.pause();
                  } else {
                    // If the video is paused, play it.
                    _controller.play();
                  }
                });
              },
              child: Text(_controller.value.isPlaying ? "PAUSE" : "PLAY"),
            ),
          ],
        ),
      ),
    );
  }
}
