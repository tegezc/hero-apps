import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:hero/config/configuration.dart';
import 'package:hero/core/log/printlog.dart';
import 'package:hero/util/component/button/component_button.dart';
import 'package:hero/util/component/label/component_label.dart';

class CoreRecordVideo extends StatefulWidget {
  int maxDurationInSecon;
  final Function(String?) onStop;
  bool isStopButtonShowing;
  CoreRecordVideo(
      {Key? key,
      required this.onStop,
      this.maxDurationInSecon = 30,
      this.isStopButtonShowing = true})
      : super(key: key);

  @override
  _CoreRecordVideoState createState() {
    return _CoreRecordVideoState();
  }
}

/// Returns a suitable camera icon for [direction].
IconData getCameraLensIcon(CameraLensDirection direction) {
  switch (direction) {
    case CameraLensDirection.back:
      return Icons.camera_rear;
    case CameraLensDirection.front:
      return Icons.camera_front;
    case CameraLensDirection.external:
      return Icons.camera;
    default:
      throw ArgumentError('Unknown lens direction');
  }
}

void logError(String code, String? message) {
  if (message != null) {
    ph('Error: $code\nError Message: $message');
  } else {
    ph('Error: $code');
  }
}

class _CoreRecordVideoState extends State<CoreRecordVideo>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  CameraController? controller;
  XFile? imageFile;
  XFile? videoFile;

  VoidCallback? videoPlayerListener;
  bool enableAudio = true;

  double _minAvailableZoom = 1.0;
  double _maxAvailableZoom = 1.0;
  double _currentScale = 1.0;
  double _baseScale = 1.0;

  final MainConfiguration conf = MainConfiguration();

  // Counting pointers (number of user fingers on screen)
  int _pointers = 0;
  bool isInitialFinish = false;
  int _counterBuild = 0;

  Timer? _timer;

  bool _isshowtimer = false;
  int _counterTimer = 0;

  void _startTimer() {
    _counterTimer = widget.maxDurationInSecon;
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_counterTimer > 0) {
        setState(() {
          _counterTimer--;
        });
      } else {
        _timer!.cancel();
        onStopButtonPressed();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
  }

  void setupCamera() {
    _initCamera().then((value) {
      if (value) {
        setState(() {
          isInitialFinish = true;
        });
      }
    });
  }

  Future<bool> _initCamera() async {
    if (_counterBuild == 0) {
      _counterBuild++;
      try {
        WidgetsFlutterBinding.ensureInitialized();
        cameras = await availableCameras();
        if (cameras.isNotEmpty) {
          if (!(controller != null && controller!.value.isRecordingVideo)) {
            onNewCameraSelected(cameras[0]);
          }
        }
        return true;
      } on CameraException catch (e) {
        logError(e.code, e.description);
        return false;
      }
    }
    return true;
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = controller;

    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      onNewCameraSelected(cameraController.description);
    }
  }

  @override
  Widget build(BuildContext context) {
    setupCamera();
    if (!isInitialFinish) {
      return const Padding(
        padding: EdgeInsets.all(16.0),
        child: LabelBlack.title('Gagal initialitation camera.'),
      );
    }
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 20,
        ),
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
                color: controller != null && controller!.value.isRecordingVideo
                    ? Colors.redAccent
                    : Colors.grey,
                width: 3.0,
              ),
            ),
          ),
        ),
        _captureControlRowWidget(),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _cameraTogglesRowWidget(),
            ],
          ),
        ),
      ],
    );
  }

  /// Display the preview from the camera (or a message if the preview is not available).
  Widget _cameraPreviewWidget() {
    final CameraController? cameraController = controller;

    if (cameraController == null || !cameraController.value.isInitialized) {
      return const Text(
        'Tap a camera',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24.0,
          fontWeight: FontWeight.w900,
        ),
      );
    } else {
      return Listener(
        onPointerDown: (_) => _pointers++,
        onPointerUp: (_) => _pointers--,
        child: CameraPreview(
          controller!,
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onScaleStart: _handleScaleStart,
              onScaleUpdate: _handleScaleUpdate,
              onTapDown: (details) => onViewFinderTap(details, constraints),
            );
          }),
        ),
      );
    }
  }

  Widget _timerLabel() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          LabelApp.size2('$_counterTimer'),
          const SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }

  void _handleScaleStart(ScaleStartDetails details) {
    _baseScale = _currentScale;
  }

  Future<void> _handleScaleUpdate(ScaleUpdateDetails details) async {
    // When there are not exactly two fingers on screen don't scale
    if (controller == null || _pointers != 2) {
      return;
    }

    _currentScale = (_baseScale * details.scale)
        .clamp(_minAvailableZoom, _maxAvailableZoom);

    await controller!.setZoomLevel(_currentScale);
  }

  /// Display the control bar with buttons to take pictures and record videos.
  Widget _captureControlRowWidget() {
    final CameraController? cameraController = controller;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            _isshowtimer
                ? _timerLabel()
                : ButtonApp.blue(
                    'Ambil Video',
                    () {
                      if (cameraController != null &&
                          cameraController.value.isInitialized &&
                          !cameraController.value.isRecordingVideo) {
                        setState(() {
                          _isshowtimer = true;
                        });
                        _startTimer();
                        onVideoRecordButtonPressed();
                      }
                    },
                  ),
            IconButton(
              icon: const Icon(Icons.stop),
              color: Colors.red,
              onPressed: cameraController != null &&
                      cameraController.value.isInitialized &&
                      cameraController.value.isRecordingVideo
                  ? onStopButtonPressed
                  : null,
            ),
          ],
        ),
        LabelAppMiring.size4(
          'Setelah ${widget.maxDurationInSecon} detik, video akan berhenti secara otomatis.',
          color: Colors.red[900],
        ),
        const Divider(),
      ],
    );
  }

  /// Display a row of toggle to select the camera (or a message if no camera is available).
  Widget _cameraTogglesRowWidget() {
    final List<Widget> toggles = <Widget>[];

    final onChanged = (CameraDescription? description) {
      if (description == null) {
        return;
      }

      onNewCameraSelected(description);
    };

    if (cameras.isEmpty) {
      return const Text('No camera found');
    } else {
      for (CameraDescription cameraDescription in cameras) {
        toggles.add(
          SizedBox(
            width: 90.0,
            child: RadioListTile<CameraDescription>(
              title: Icon(getCameraLensIcon(cameraDescription.lensDirection)),
              groupValue: controller?.description,
              value: cameraDescription,
              onChanged:
                  controller != null && controller!.value.isRecordingVideo
                      ? null
                      : onChanged,
            ),
          ),
        );
      }
    }

    return Row(children: toggles);
  }

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  void onViewFinderTap(TapDownDetails details, BoxConstraints constraints) {
    if (controller == null) {
      return;
    }

    final CameraController cameraController = controller!;

    final offset = Offset(
      details.localPosition.dx / constraints.maxWidth,
      details.localPosition.dy / constraints.maxHeight,
    );
    cameraController.setExposurePoint(offset);
    cameraController.setFocusPoint(offset);
  }

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller!.dispose();
    }

    final CameraController cameraController = CameraController(
      cameraDescription,
      conf.vidResolution(),
      enableAudio: enableAudio,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    try {
      await cameraController.setFlashMode(FlashMode.off);
      await cameraController.setFocusMode(FocusMode.locked);
      await cameraController.setExposureMode(ExposureMode.auto);
    } on CameraException catch (e, m) {
      ph('$e,$m');
    } catch (e) {
      ph(e);
    }

    controller = cameraController;

    // If the controller is updated then update the UI.
    cameraController.addListener(() {
      if (mounted) setState(() {});
      if (cameraController.value.hasError) {
        ph('Camera error ${cameraController.value.errorDescription}');
      }
    });

    try {
      await cameraController.initialize();
      await Future.wait([
        // The exposure mode is currently not supported on the web.
        ...(!kIsWeb
            ? [
                cameraController.getMinExposureOffset().then((value) {}),
                cameraController.getMaxExposureOffset().then((value) {})
              ]
            : []),
        cameraController
            .getMaxZoomLevel()
            .then((value) => _maxAvailableZoom = value),
        cameraController
            .getMinZoomLevel()
            .then((value) => _minAvailableZoom = value),
      ]);
    } on CameraException catch (e) {
      _showCameraException(e);
    }

    if (mounted) {
      setState(() {});
    }
  }

  void onVideoRecordButtonPressed() {
    startVideoRecording().then((_) {
      if (mounted) setState(() {});
    });
  }

  void onStopButtonPressed() {
    _isshowtimer = false;
    stopVideoRecording().then((file) {
      if (mounted) setState(() {});

      videoFile = file;
      if (videoFile != null) {
        widget.onStop(videoFile!.path);
      } else {
        widget.onStop(null);
      }
    });
  }

  Future<void> startVideoRecording() async {
    final CameraController? cameraController = controller;

    if (cameraController == null || !cameraController.value.isInitialized) {
      ph('Error: select a camera first.');
      return;
    }

    if (cameraController.value.isRecordingVideo) {
      // A recording is already started, do nothing.
      return;
    }

    try {
      await cameraController.setFlashMode(FlashMode.off);
      await cameraController.startVideoRecording();
    } on CameraException catch (e) {
      _showCameraException(e);
      return;
    }
  }

  Future<XFile?> stopVideoRecording() async {
    final CameraController? cameraController = controller;

    if (cameraController == null || !cameraController.value.isRecordingVideo) {
      return null;
    }

    try {
      return cameraController.stopVideoRecording();
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
  }

  void _showCameraException(CameraException e) {
    logError(e.code, e.description);
    ph('Error: ${e.code}\n${e.description}');
  }
}

List<CameraDescription> cameras = [];
