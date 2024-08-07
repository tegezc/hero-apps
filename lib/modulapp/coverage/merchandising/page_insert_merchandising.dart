import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hero/core/log/printlog.dart';
import 'package:hero/model/enumapp.dart';
import 'package:hero/model/merchandising/merchandising.dart';
import 'package:hero/modulapp/camera/pagetakephoto.dart';
import 'package:hero/modulapp/camera/preferencephoto.dart';
import 'package:hero/modulapp/coverage/merchandising/blocmerchandising.dart';
import 'package:hero/util/component/button/component_button.dart';
import 'package:hero/util/component/label/component_label.dart';
import 'package:hero/util/component/textfield/component_textfield.dart';
import 'package:hero/util/component/tgzdialog.dart';
import 'package:hero/util/component/widget/component_widget.dart';
import 'package:hero/util/component/widget/widget_success_submit.dart';

class PageInsertMerchandising extends StatefulWidget {
  final EnumMerchandising enumMerchandising;
  final Merchandising? merchandising;
  final BlocMerchandising? blocMerchandising;
  const PageInsertMerchandising(
      this.enumMerchandising, this.merchandising, this.blocMerchandising,
      {Key? key})
      : super(key: key);
  @override
  _PageInsertMerchandisingState createState() =>
      _PageInsertMerchandisingState();
}

class _PageInsertMerchandisingState extends State<PageInsertMerchandising> {
  final TextEditingController _telkomselController = TextEditingController();
  final TextEditingController _isatController = TextEditingController();
  final TextEditingController _xlController = TextEditingController();
  final TextEditingController _triController = TextEditingController();
  final TextEditingController _smartController = TextEditingController();
  final TextEditingController _axisController = TextEditingController();
  final TextEditingController _otherController = TextEditingController();
  String? _title;

  int _buildCounter = 0;
  @override
  void initState() {
    switch (widget.enumMerchandising) {
      case EnumMerchandising.spanduk:
        _title = 'Layar Toko';
        break;
      case EnumMerchandising.poster:
        _title = 'Poster';
        break;
      case EnumMerchandising.papan:
        _title = 'Papan';
        break;
      case EnumMerchandising.stikerScanQR:
        _title = 'STIKER OMNI CHANNEL'; // 'Stiker Scan QR';
        break;
      case EnumMerchandising.perdana:
        _title = 'Perdana';
        break;
      case EnumMerchandising.voucherfisik:
        _title = 'Voucher Fisik';
        break;
    }

    super.initState();
  }

  @override
  void dispose() {
    _telkomselController.dispose();
    _isatController.dispose();
    _xlController.dispose();
    _triController.dispose();
    _smartController.dispose();
    _axisController.dispose();
    _otherController.dispose();
    super.dispose();
  }

  void _setValue() {
    // ph(widget.merchandising);
    // ph(widget.merchandising.isPhotoShowing());
    _telkomselController.text = widget.merchandising!.telkomsel != null
        ? '${widget.merchandising!.telkomsel}'
        : '';
    _isatController.text = widget.merchandising!.isat == null
        ? ''
        : '${widget.merchandising!.isat}';
    _xlController.text =
        widget.merchandising!.xl == null ? '' : '${widget.merchandising!.xl}';
    _triController.text =
        widget.merchandising!.tri == null ? '' : '${widget.merchandising!.tri}';
    _smartController.text =
        widget.merchandising!.sf == null ? '' : '${widget.merchandising!.sf}';
    _axisController.text = widget.merchandising!.axis == null
        ? ''
        : '${widget.merchandising!.axis}';
    _otherController.text = widget.merchandising!.other == null
        ? ''
        : '${widget.merchandising!.other}';
  }

  @override
  Widget build(BuildContext context) {
    if (_buildCounter == 0) {
      _setValue();
      _buildCounter++;
    }
    // _setValue();
    Size s = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.merchandising!.isServerExist
                ? _successDisubmit()
                : Container(),
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
            widget.merchandising!.isTakePhotoShowing()
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
                      bool isValidToSubmit;
                      if (widget.enumMerchandising ==
                          EnumMerchandising.stikerScanQR) {
                        if (widget.merchandising!.telkomsel == 0 ||
                            widget.merchandising!.telkomsel == 1) {
                          isValidToSubmit = true;
                        } else {
                          isValidToSubmit = false;
                          TgzDialog.confirmHarusDiisiStickerScanQr(context);
                        }
                      } else {
                        isValidToSubmit =
                            widget.merchandising!.isvalidtosubmit();
                        if (!isValidToSubmit) {
                          TgzDialog.confirmHarusDiisi(context);
                        }
                      }

                      if (isValidToSubmit) {
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
                        }
                      }
                    },
                    isenable: true),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }

  Widget _successDisubmit() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: WidgeSuccessSubmit(),
    );
  }

  void _takePhoto() async {
    if (widget.merchandising!.isvalidtakephoto()) {
      ParamPreviewPhoto? params;
      switch (widget.enumMerchandising) {
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
        case EnumMerchandising.stikerScanQR:
          params = ParamPreviewPhoto(EnumTakePhoto.merchbackdrop,
              pathPhoto: null, enumNumber: widget.merchandising!.getPhotoKe());
          break;
        case EnumMerchandising.perdana:
          params = ParamPreviewPhoto(EnumTakePhoto.merchperdana,
              pathPhoto: null, enumNumber: widget.merchandising!.getPhotoKe());
          break;
        case EnumMerchandising.voucherfisik:
          params = ParamPreviewPhoto(EnumTakePhoto.merchvoucherfisik,
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
    ph('TAB: ${widget.enumMerchandising}');
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
    bool enableTextfield = !widget.merchandising!.isServerExist;
    ph('Merch Enable Button Before $enableTextfield');
    // kondisi khusus untuk sticker
    if (enableTextfield &&
        widget.enumMerchandising == EnumMerchandising.stikerScanQR) {
      if (enumOperator != EnumOperator.telkomsel) {
        enableTextfield = false;
      }
    }
    //=============

    ph('Merch Enable Button $enableTextfield');
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
              enable: enableTextfield,
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
                      ph(exception);
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
              title: const LabelApp.size1(
                'Confirm',
                color: Colors.green,
              ),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              children: <Widget>[
                const Padding(
                  padding:
                      EdgeInsets.only(right: 16.0, left: 16.0, bottom: 3.0),
                  child: LabelBlack.size2('Merchandising berhasil disimpan.'),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0, left: 16.0, bottom: 3.0),
                  child: ButtonApp.black('Ok', () {
                    widget.blocMerchandising!.refreshPage();
                    Navigator.of(context).pop();
                  }),
                ),
              ],
            ));
  }

  _confirmGagalMenyimpan() {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => SimpleDialog(
              title: const LabelApp.size1(
                'Confirm',
                color: Colors.red,
              ),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              children: <Widget>[
                const Padding(
                  padding:
                      EdgeInsets.only(right: 16.0, left: 16.0, bottom: 3.0),
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
              title: const LabelApp.size1(
                'Confirm',
                color: Colors.red,
              ),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              children: <Widget>[
                const Padding(
                  padding:
                      EdgeInsets.only(right: 16.0, left: 16.0, bottom: 3.0),
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
}
