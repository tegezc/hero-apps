// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:hero/model/pjp.dart';
import 'package:hero/modulapp/camera/previewphotoupload.dart';
import 'package:hero/util/filesystem/itgzfile.dart';
import 'package:hero/util/filesystem/tgzfile.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

import 'loadingview.dart';
import 'preferencephoto.dart';
import 'previewphoto.dart';

List<CameraDescription> cameras = [];

class CameraView extends StatefulWidget {
  static const routeName = '/takephoto';
  final ParamPreviewPhoto? params;
  CameraView(this.params);
  @override
  _CameraViewState createState() {
    return _CameraViewState();
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
  }
  // throw ArgumentError('Unknown lens direction');
}

void logError(String code, String? message) =>
    debugPrint('Error: $code\nError Message: $message');

class _CameraViewState extends State<CameraView> with WidgetsBindingObserver {
  List<CameraDescription> cameras = [];
  CameraController? controller;
  // String imagePath;
  String? videoPath;
  VideoPlayerController? videoController;
  VoidCallback? videoPlayerListener;
  bool enableAudio = true;

  late bool _isLoading;

  @override
  void initState() {
    _isLoading = true;
    super.initState();
    _initialCamera().then((value) {
      setState(() {
        _isLoading = false;
        if (cameras.isNotEmpty) {
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
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // App state changed before we got the chance to initialize.
    if (controller == null || !controller!.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      controller?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      if (controller != null) {
        onNewCameraSelected(controller!.description);
      }
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return LoadingNunggu('Menunggu camera');
    }
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Take Photo'),
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
                      controller != null && controller!.value.isRecordingVideo
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
                Container()
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
    if (controller == null || !controller!.value.isInitialized) {
      return const Text(
        'Tap a camera',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24.0,
          fontWeight: FontWeight.w900,
        ),
      );
    } else {
      // return AspectRatio(
      //   aspectRatio: controller!.value.aspectRatio,
      //   child: CameraPreview(controller!),
      // );
      return CameraPreview(controller!);
    }
  }

  /// Display the control bar with buttons to take pictures and record videos.
  Widget _captureControlRowWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.camera_alt),
          color: Colors.blue,
          onPressed: controller != null && controller!.value.isInitialized
              ? onTakePictureButtonPressed
              : null,
        ),
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
              selected: true,
              title: Icon(getCameraLensIcon(cameraDescription.lensDirection)),
              groupValue: controller?.description,
              value: cameraDescription,
              onChanged:
                  controller != null && controller!.value.isRecordingVideo
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

  void showInSnackBar(String message) {
    //_scaffoldKey.currentState!.showSnackBar(SnackBar(content: Text(message)));
  }

  void onNewCameraSelected(CameraDescription? cameraDescription) async {
    if (controller != null) {
      await controller!.dispose();
    }
    controller = CameraController(
      cameraDescription!,
      ResolutionPreset.low,
      enableAudio: enableAudio,
    );

    // If the controller is updated then update the UI.
    controller!.addListener(() {
      if (mounted) setState(() {});
      if (controller!.value.hasError) {
        showInSnackBar('Camera error ${controller!.value.errorDescription}');
      }
    });

    try {
      await controller!.initialize();
    } on CameraException catch (e) {
      _showCameraException(e);
    }

    if (mounted) {
      setState(() {});
    }
  }

  // XFile? imageFile;
  void onTakePictureButtonPressed() {
    takePicture().then((String? filePath) {
      if (mounted) {
        setState(() {
          //   imagePath = filePath;
          // imageFile = filePath;
          videoController?.dispose();
          videoController = null;
        });
        if (filePath != null) {
          ///data/data/com.tgz.cobacamera/app_flutter/Pictures/flutter_test/1603038382586.jpg

          //  showInSnackBar('Picture saved to $filePath');
          ParamPreviewPhoto params = widget.params!;
          params.pathPhoto = filePath;

          if (widget.params!.enumTakePhoto != EnumTakePhoto.distribusi &&
              widget.params!.enumTakePhoto != EnumTakePhoto.distibusiclose) {
            Navigator.pushNamed(
              context,
              PreviewPhoto.routeName,
              arguments: params,
            );
          } else {
            Navigator.pushNamed(
              context,
              PreviewPhotoWithUpload.routeName,
              arguments: params,
            );
          }
        }
      }
    });
  }

  Future<String?> takePicture() async {
    if (!controller!.value.isInitialized) {
      showInSnackBar('Error: select a camera first.');
      return null;
    }

    if (controller!.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      XFile rawImage = await controller!.takePicture();
      return await _copyPhotoFroCacheToDestinationDirectory(rawImage);
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
  }

  Future<String?> _copyPhotoFroCacheToDestinationDirectory(
      XFile sourceFile) async {
    try {
      final Directory? extDir =
          await getExternalStorageDirectory(); //getApplicationDocumentsDirectory();
      final String dirPath = '${extDir!.path}/photo';
      await Directory(dirPath).create(recursive: true);

      final String filePath = '$dirPath/${timestamp()}.jpeg';

      File imageFile = File(sourceFile.path);

      await imageFile.copy(
        filePath,
      );
      return filePath;
    } catch (e) {
      return null;
    }
  }

  void _showCameraException(CameraException e) {
    logError(e.code, e.description);
    showInSnackBar('Error: ${e.code}\n${e.description}');
  }
}

enum EnumTakePhoto {
  distribusi,
  marketaudit,
  distibusiclose,
  merchperdana,
  merchvoucherfisik,
  merchspanduk,
  merchposter,
  merchpapan,
  merchbackdrop
}

class ParamPreviewPhoto {
  String? pathPhoto;
  EnumTakePhoto enumTakePhoto;
  EnumNumber? enumNumber;
  ITgzFile tgzFile;
  Pjp? pjp;

  Future<String?> getPhotoUrlOrNull() async {
    if (pathPhoto != null) {
      String urlImage = pathPhoto!;
      if (await tgzFile.isPathExist(urlImage)) {}
      return urlImage;
    }
    return null;
  }

  ParamPreviewPhoto(this.enumTakePhoto,
      {this.pathPhoto, this.enumNumber, this.pjp})
      : tgzFile = TgzFile();
}
