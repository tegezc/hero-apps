import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hero/model/enumapp.dart';
import 'package:hero/model/merchandising/merchandising.dart';
import 'package:hero/modulapp/camera/loadingview.dart';
import 'package:hero/modulapp/camera/pagetakephoto.dart';
import 'package:hero/modulapp/camera/preferencephoto.dart';
import 'package:hero/modulapp/coverage/merchandising/blocmerchandising.dart';
import 'package:hero/util/component/button/component_button.dart';
import 'package:hero/util/component/label/component_label.dart';
import 'package:hero/util/component/textfield/component_textfield.dart';
import 'package:hero/util/component/widget/component_widget.dart';

class PageMerchandising extends StatefulWidget {
  final EnumMerchandising enumMerchandising;
  final Merchandising? merchandising;
  final BlocMerchandising? blocMerchandising;
  PageMerchandising(
      this.enumMerchandising, this.merchandising, this.blocMerchandising);
  @override
  _PageMerchandisingState createState() => _PageMerchandisingState();
}

class _PageMerchandisingState extends State<PageMerchandising> {
  TextEditingController? _telkomselController;
  TextEditingController? _isatController;
  TextEditingController? _xlController;
  TextEditingController? _triController;
  TextEditingController? _smartController;
  TextEditingController? _axisController;
  TextEditingController? _otherController;
  String? _title;
  @override
  void initState() {
    switch (widget.enumMerchandising) {
      case EnumMerchandising.etalase:
        _title = 'Etalase';
        break;
      case EnumMerchandising.spanduk:
        _title = 'Spanduk';
        break;
      case EnumMerchandising.poster:
        _title = 'Poster';
        break;
      case EnumMerchandising.papan:
        _title = 'Papan';
        break;
      case EnumMerchandising.backdrop:
        _title = 'Backdrop';
        break;
    }
    _telkomselController = new TextEditingController();
    _isatController = new TextEditingController();
    _xlController = new TextEditingController();
    _triController = new TextEditingController();
    _smartController = new TextEditingController();
    _axisController = new TextEditingController();
    _otherController = new TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _telkomselController!.dispose();
    _isatController!.dispose();
    _xlController!.dispose();
    _triController!.dispose();
    _smartController!.dispose();
    _axisController!.dispose();
    _otherController!.dispose();
    super.dispose();
  }

  void _setValue() {
    // print(widget.merchandising);
    // print(widget.merchandising.isPhotoShowing());
    _telkomselController!.text = widget.merchandising!.telkomsel != null
        ? '${widget.merchandising!.telkomsel}'
        : '';
    _isatController!.text = widget.merchandising!.isat == null
        ? ''
        : '${widget.merchandising!.isat}';
    _xlController!.text =
        widget.merchandising!.xl == null ? '' : '${widget.merchandising!.xl}';
    _triController!.text =
        widget.merchandising!.tri == null ? '' : '${widget.merchandising!.tri}';
    _smartController!.text =
        widget.merchandising!.sf == null ? '' : '${widget.merchandising!.sf}';
    _axisController!.text = widget.merchandising!.axis == null
        ? ''
        : '${widget.merchandising!.axis}';
    _otherController!.text = widget.merchandising!.other == null
        ? ''
        : '${widget.merchandising!.other}';
  }

  @override
  Widget build(BuildContext context) {
    _setValue();
    Size s = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 8),
              child: LabelBlack.title(
                _title,
                bold: true,
              ),
            )),
            _cardForm(s.width),
            const SizedBox(height: 10),
            widget.merchandising!.isPhotoShowing()
                ? ButtonStrectWidth(
                    buttonColor: Colors.green,
                    text: "Ambil Foto",
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      _takePhoto();
                    },
                    isenable: true)
                : Container(),
            _listPhoto(
              s.width,
              widget.merchandising!.pathPhoto1,
              widget.merchandising!.pathPhoto2,
              widget.merchandising!.pathPhoto3,
            ),
            widget.merchandising!.isServerExist
                ? Container()
                : ButtonStrectWidth(
                    buttonColor: Colors.red,
                    text: "SUBMIT",
                    onTap: () {
                      if (widget.merchandising!.isvalidtosubmit()) {
                        TgzDialog.loadingDialog(context);
                        widget.blocMerchandising!
                            .submit(widget.enumMerchandising)
                            .then((value) {
                          Navigator.of(context).pop();
                          if (value) {
                            _confirmSuccessSimpan();
                          } else {
                            _confirmGagalMenyimpan();
                          }
                        });
                      } else {
                        TgzDialog.confirmHarusDiisi(context);
                      }
                    },
                    isenable: true),
            SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }

  void _takePhoto() async {
    if (widget.merchandising!.isvalidtakephoto()) {
      ParamPreviewPhoto? params;
      switch (widget.enumMerchandising) {
        case EnumMerchandising.etalase:
          params = ParamPreviewPhoto(EnumTakePhoto.merchetalase,
              pathPhoto: null, enumNumber: widget.merchandising!.getPhotoKe());

          break;
        case EnumMerchandising.spanduk:
          params = ParamPreviewPhoto(EnumTakePhoto.merchspanduk,
              pathPhoto: null, enumNumber: widget.merchandising!.getPhotoKe());
          break;
        case EnumMerchandising.poster:
          params = ParamPreviewPhoto(EnumTakePhoto.merchposter,
              pathPhoto: null, enumNumber: widget.merchandising!.getPhotoKe());
          break;
        case EnumMerchandising.papan:
          params = ParamPreviewPhoto(EnumTakePhoto.merchpapan,
              pathPhoto: null, enumNumber: widget.merchandising!.getPhotoKe());
          break;
        case EnumMerchandising.backdrop:
          params = ParamPreviewPhoto(EnumTakePhoto.merchbackdrop,
              pathPhoto: null, enumNumber: widget.merchandising!.getPhotoKe());
          break;
      }
      await Navigator.pushNamed(
        context,
        CameraView.routeName,
        arguments: params,
      );

      StoredPathPhoto.getPhotoMerchandising(
              widget.enumMerchandising, widget.merchandising!.getPhotoKe())
          .then((value) {
        widget.blocMerchandising!.setPhotoPath(widget.enumMerchandising, value);
      });
    } else {
      _confirmTakePhotoNotValid();
    }
  }

  Widget _cardForm(double width) {
    double w = width - 120;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _cellForm(
                w, 'Telkomsel', _telkomselController, EnumOperator.telkomsel),
            _cellForm(w, 'Isat', _isatController, EnumOperator.isat),
            _cellForm(w, 'XL', _xlController, EnumOperator.xl),
            _cellForm(w, '3', _triController, EnumOperator.tri),
            _cellForm(w, 'Smartfren', _smartController, EnumOperator.sf),
            _cellForm(w, 'Axis', _axisController, EnumOperator.axis),
            _cellForm(w, 'Other', _otherController, EnumOperator.other),
          ],
        ),
      ),
    );
  }

  Widget _cellForm(double width, String label,
      TextEditingController? controller, EnumOperator enumOperator) {
    return Row(
      children: [
        SizedBox(width: 80, child: LabelBlack.size2(label)),
        SizedBox(
            width: width,
            child: TextFieldNumberOnly(
              '',
              controller,
              onChanged: (str) {
                widget.blocMerchandising!
                    .changeText(widget.enumMerchandising, str, enumOperator);
              },
              enable: !widget.merchandising!.isServerExist,
            ))
      ],
    );
  }

  Widget _listPhoto(
    double width,
    String? path1,
    String? path2,
    String? path3,
  ) {
    return Card(
      child: Wrap(
        direction: Axis.horizontal,
        children: [
          widget.merchandising!.isServerExist
              ? _showImageFromInternet(path1)
              : _showImage(path1),
          widget.merchandising!.isServerExist
              ? _showImageFromInternet(path2)
              : _showImage(path2),
          widget.merchandising!.isServerExist
              ? _showImageFromInternet(path3)
              : _showImage(path3),
        ],
      ),
    );
  }

  Widget _showImage(String? url) {
    return url == null
        ? Container()
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: ContainerRounded(
              borderColor: Colors.black,
              radius: 4.0,
              child: FractionallySizedBox(
                  widthFactor: 0.9,
                  child: Image.file(
                    File(url),
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      print(exception);
                      return Container();
                    },
                  )),
            ),
          );
  }

  Widget _showImageFromInternet(String? url) {
    return url == null
        ? Container()
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: ContainerRounded(
              borderColor: Colors.black,
              radius: 4.0,
              child: FractionallySizedBox(
                  widthFactor: 0.9,
                  child: Image.network(
                    url,
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      print(exception);
                      return Container();
                    },
                  )),
            ),
          );
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
                  child: LabelBlack.size2('Merchandising berhasil disimpan.'),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0, left: 16.0, bottom: 3.0),
                  child: ButtonApp.black('Ok', () {
                    Navigator.of(context).pop();
                    widget.blocMerchandising!.refreshPage();
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
                  child: LabelBlack.size2('Merchandising gagal disimpan.'),
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

  _confirmTakePhotoNotValid() {
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
                  child: LabelBlack.size2(
                      'Tidak dapat mengambil photo karena semua bernilai nol.'),
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

  // _loadingDialog() {
  //   showDialog<String>(
  //       context: context,
  //       builder: (BuildContext context) => SimpleDialog(
  //             title: LabelApp.size1(
  //               'Loading...',
  //               color: Colors.red,
  //             ),
  //             shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.all(Radius.circular(15.0))),
  //             children: <Widget>[
  //               LoadingBouncingLine.circle(backgroundColor: Colors.deepOrange),
  //             ],
  //           ));
  // }
}
