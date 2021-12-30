import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:hero/http/coverage/httppromotion.dart';
import 'package:hero/model/promotion/promotion.dart';
import 'package:hero/modulapp/camera/loadingview.dart';
import 'package:hero/modulapp/coverage/promotion/hppromotion.dart';
import 'package:hero/util/component/component_button.dart';
import 'package:hero/util/component/component_label.dart';
import 'package:hero/util/component/component_textfield.dart';
import 'package:hero/util/component/component_widget.dart';
import 'package:hero/util/constapp/consstring.dart';
import 'package:video_player/video_player.dart';

class PreviewVideoUpload extends StatefulWidget {
  static const String routeName = '/pagevideoupload';
  final ParamPreviewVideo? param;
  PreviewVideoUpload(this.param);
  @override
  _PreviewVideoUploadState createState() => _PreviewVideoUploadState();
}

class _PreviewVideoUploadState extends State<PreviewVideoUpload> {
  late VideoPlayerController _controller;
  TextEditingController _controllerText = TextEditingController();
  String programlocal = 'PROGRAM LOKAL';
  bool _isloading = true;
  Promotion? _promotion;
  @override
  void initState() {
    _promotion = widget.param!.promotion;
    _controllerText.text =
        _promotion!.nama == programlocal ? _promotion!.nmlocal! : '';
    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.file(
      File(widget.param!.source!.path),
    );

    // Initialize the controller and store the Future for later use.
    _controller.initialize().then((value) {
      setState(() {
        _isloading = false;
      });
    });

    // Use the controller to loop the video.
    _controller.setLooping(true);
    super.initState();
  }

  @override
  void dispose() {
    _controllerText.dispose();
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //   Size size = MediaQuery.of(context).size;
    if (_isloading) {
      return CustomScaffold(body: Container(), title: 'Loading...');
    }
    return CustomScaffold(
        body: Container(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  LabelBlack.size1(
                    widget.param!.promotion!.nama,
                    bold: true,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  _promotion!.nama == programlocal
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:
                              TextFieldLogin('Nama Program', _controllerText),
                        )
                      : Container(),
                  SizedBox(
                    height: 20,
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
                  IconButton(
                      icon: Icon(
                        _controller.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                      ),
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
                      }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ButtonApp.blue('Upload', () {
                        if (_promotion!.nama == programlocal) {
                          _promotion!.nmlocal = _controllerText.text;
                        }
                        TgzDialog.loadingDialog(context);
                        HttpPromotion httpPromotion = HttpPromotion();
                        httpPromotion
                            .uploadVideo(widget.param!.source!.path, _promotion!)
                            .then((value) {
                          Navigator.of(context).pop();
                          if (value) {
                            _confirmSuccessSimpan();
                          } else {
                            _confirmGagalMenyimpan();
                          }
                        });
                      }),
                      ButtonApp.blue('Ambil Lagi', () {
                        Navigator.of(context).pop();
                      }),
                      //   ButtonApp.blue('Cancel', () {}),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        title: ConstString.textPromotion);
  }

  _confirmSuccessSimpan() {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => SimpleDialog(
              title: LabelApp.size1(
                'Confirm',
                color: Colors.green,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0, left: 16.0, bottom: 3.0),
                  child: LabelBlack.size2('Video berhasil di upload.'),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0, left: 16.0, bottom: 3.0),
                  child: ButtonApp.black('Ok', () {
                    Navigator.of(context).pop();
                    Navigator.popUntil(
                        context,
                        ModalRoute.withName(
                          HomePagePromotion.routeName,
                        ));
                  }),
                ),
              ],
            ));
  }

  _confirmGagalMenyimpan() {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => SimpleDialog(
              title: LabelApp.size1(
                'Confirm',
                color: Colors.red,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0, left: 16.0, bottom: 3.0),
                  child: LabelBlack.size2('Video gagal di upload.'),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0, left: 16.0, bottom: 3.0),
                  child: ButtonApp.black('Ok', () {
                    Navigator.of(context).pop();
                  }),
                ),
              ],
            ));
  }
}

class ParamPreviewVideo {
  XFile? source;
  Promotion? promotion;

  ParamPreviewVideo(this.source, this.promotion);
}
