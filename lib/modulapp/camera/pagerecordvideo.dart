import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:hero/model/promotion/promotion.dart';
import 'package:hero/util/component/component_button.dart';
import 'package:hero/util/component/component_label.dart';
import 'package:path_provider/path_provider.dart';
//import 'package:video_player/video_player.dart';

import 'loadingview.dart';
import 'previewvideo.dart';

IconData getCameraLensIcon(CameraLensDirection direction) {
  switch (direction) {
    case CameraLensDirection.back:
      return Icons.camera_rear;
    case CameraLensDirection.front:
      return Icons.camera_front;
    case CameraLensDirection.external:
      return Icons.camera;
  }
  // throw ArgumentError('Unknown lens direction');
}

void logError(String code, String? message) =>
    print('Error: $code\nError Message: $message');

class PageTakeVideo extends StatefulWidget {
  static const routeName = 'pagevideopromotion';
  final Promotion? promotion;

  PageTakeVideo(this.promotion);

  @override
  _PageTakeVideoState createState() => _PageTakeVideoState();
}

class _PageTakeVideoState extends State<PageTakeVideo>
    with WidgetsBindingObserver {
  List<CameraDescription> cameras = [];
  CameraController? _controller;
  XFile? _videoPath;
  // VideoPlayerController _videoController;
//  VoidCallback _videoPlayerListener;
  bool _enableAudio = true;
  late bool _isloading;
  Timer? _timer;
  int _counter = 30;
  bool _isshowtimer = false;

  void _startTimer() {
    _counter = 30;
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter > 0) {
          _counter--;
        } else {
          _timer!.cancel();
          stopVideoRecording().then((file) async {
            if (mounted) setState(() {});
            print('Video recorded to: $_videoPath');
            _videoPath = file;
            ParamPreviewVideo param =
                ParamPreviewVideo(_videoPath, widget.promotion);
            await Navigator.pushNamed(
              context,
              PreviewVideoUpload.routeName,
              arguments: param,
            );
            setState(() {
              _isshowtimer = false;
            });
          });
        }
      });
    });
  }

  @override
  void initState() {
    _isloading = true;
    super.initState();
    _initialCamera().then((value) {
      setState(() {
        _isloading = false;
        if (cameras.length > 0) {
          onNewCameraSelected(cameras[0]);
        }
      });
    });
    WidgetsBinding.instance!.addObserver(this);
  }

  Future<bool> _initialCamera() async {
    cameras = await availableCameras();
    return true;
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    _timer?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // App state changed before we got the chance to initialize.
    if (_controller == null || !_controller!.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      _controller?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      if (_controller != null) {
        onNewCameraSelected(_controller!.description);
      }
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    if (_isloading) {
      return LoadingNunggu('Menunggu camera');
    }
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Video'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Center(
                  child: _cameraPreviewWidget(),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.black,
                border: Border.all(
                  color:
                      _controller != null && _controller!.value.isRecordingVideo
                          ? Colors.redAccent
                          : Colors.grey,
                  width: 3.0,
                ),
              ),
            ),
          ),
          _isshowtimer ? _timer30Detik() : _captureControlRowWidget(),
          _isshowtimer
              ? Container()
              : Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      _cameraTogglesRowWidget(),
                      //   _thumbnailWidget(),
                    ],
                  ),
                ),
        ],
      ),
    );
  }

  /// Display the preview from the camera (or a message if the preview is not available).
  Widget _cameraPreviewWidget() {
    if (_controller == null || !_controller!.value.isInitialized) {
      return const Text(
        'Tap a camera',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24.0,
          fontWeight: FontWeight.w900,
        ),
      );
    } else {
      return AspectRatio(
        aspectRatio: _controller!.value.aspectRatio,
        child: CameraPreview(_controller!),
      );
    }
  }

  Widget _timer30Detik() {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, bottom: 16),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              LabelApp.size2('$_counter'),
              SizedBox(
                height: 8,
              ),
              LabelAppMiring.size3(
                'Setelah 30 detik, video akan berhenti secara otomatis.',
                color: Colors.red[900],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Display the control bar with buttons to take pictures and record videos.
  Widget _captureControlRowWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        ButtonApp.blue(
            'Start Record Video',
            _controller != null &&
                    _controller!.value.isInitialized &&
                    !_controller!.value.isRecordingVideo
                ? onVideoRecordButtonPressed
                : () {}),
      ],
    );
  }

  /// Display a row of toggle to select the camera (or a message if no camera is available).
  Widget _cameraTogglesRowWidget() {
    final List<Widget> toggles = <Widget>[];

    if (cameras.isEmpty) {
      return const Text('No camera found');
    } else {
      for (CameraDescription cameraDescription in cameras) {
        toggles.add(
          SizedBox(
            width: 90.0,
            child: RadioListTile<CameraDescription>(
              title: Icon(getCameraLensIcon(cameraDescription.lensDirection)),
              groupValue: _controller?.description,
              value: cameraDescription,
              onChanged:
                  _controller != null && _controller!.value.isRecordingVideo
                      ? null
                      : onNewCameraSelected,
            ),
          ),
        );
      }
    }

    return Row(children: toggles);
  }

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  // void showInSnackBar(String message) {
  //    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  //  }

  void onNewCameraSelected(CameraDescription? cameraDescription) async {
    if (_controller != null) {
      await _controller!.dispose();
    }
    _controller = CameraController(
      cameraDescription!,
      ResolutionPreset.medium,
      enableAudio: _enableAudio,
    );

    // If the controller is updated then update the UI.
    _controller!.addListener(() {
      if (mounted) setState(() {});
      if (_controller!.value.hasError) {
        print('Camera error ${_controller!.value.errorDescription}');
      }
    });

    try {
      await _controller!.initialize();
    } on CameraException catch (e) {
      _showCameraException(e);
    }

    if (mounted) {
      setState(() {});
    }
  }

  void onVideoRecordButtonPressed() {
    startVideoRecording().then((_) {
      _isshowtimer = true;
      _startTimer();
      if (mounted) setState(() {});
      // if (filePath != null) showInSnackBar('Saving video to $filePath');
    });
  }

  // void onStopButtonPressed() {
  //   stopVideoRecording().then((_) {
  //     if (mounted) setState(() {});
  //     print('Video recorded to: $_videoPath');
  //   });
  // }

  // void onPauseButtonPressed() {
  //   pauseVideoRecording().then((_) {
  //     if (mounted) setState(() {});
  //     print('Video recording paused');
  //   });
  // }
  //
  // void onResumeButtonPressed() {
  //   resumeVideoRecording().then((_) {
  //     if (mounted) setState(() {});
  //     showInSnackBar('Video recording resumed');
  //   });
  // }

  Future<void> startVideoRecording() async {
    if (!_controller!.value.isInitialized) {
      print('Error: select a camera first.');
      // return null;
    }

    final Directory? extDir =
        await  getExternalStorageDirectory() ; //getApplicationDocumentsDirectory();
    final String dirPath = '${extDir!.path}/video/';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath${timestamp()}.mp4';

    if (_controller!.value.isRecordingVideo) {
      // A recording is already started, do nothing.
      // return null;
    }

    try {
      print('video: $filePath');

      /// comment error sementara
      await _controller!.startVideoRecording();
      ///end
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
    // return filePath;
  }

  Future<XFile?> stopVideoRecording() async {
    if (!_controller!.value.isRecordingVideo) {
      return null;
    }

    try {
      return _controller!.stopVideoRecording();
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }

    // await _startVideoPlayer();
  }

  // Future<void> _startVideoPlayer() async {
  //   final VideoPlayerController vcontroller =
  //       VideoPlayerController.file(File(_videoPath));
  //   _videoPlayerListener = () {
  //     if (_videoController != null && _videoController.value.size != null) {
  //       // Refreshing the state to update video player with the correct ratio.
  //       if (mounted) setState(() {});
  //       _videoController.removeListener(_videoPlayerListener);
  //     }
  //   };
  //   vcontroller.addListener(_videoPlayerListener);
  //   await vcontroller.setLooping(true);
  //   await vcontroller.initialize();
  //   await _videoController?.dispose();
  //   if (mounted) {
  //     setState(() {
  //       _videoController = vcontroller;
  //     });
  //   }
  //   await vcontroller.play();
  // }

  void _showCameraException(CameraException e) {
    logError(e.code, e.description);
    print('Error: ${e.code}\n${e.description}');
  }
}
