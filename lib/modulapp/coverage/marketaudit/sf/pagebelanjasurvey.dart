import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hero/modulapp/camera/loadingview.dart';
import 'package:hero/modulapp/camera/pagetakephoto.dart';
import 'package:hero/modulapp/camera/preferencephoto.dart';
import 'package:hero/modulapp/coverage/marketaudit/sf/blocsurvey.dart';
import 'package:hero/modulapp/coverage/merchandising/blocmerchandising.dart';
import 'package:hero/util/component/button/component_button.dart';
import 'package:hero/util/component/label/component_label.dart';
import 'package:hero/util/component/textfield/component_textfield.dart';
import 'package:hero/util/component/widget/component_widget.dart';
import 'package:hero/util/component/widget/widget_success_submit.dart';

class PageBelanjaSurvey extends StatefulWidget {
  final UISurvey? uiSurvey;
  final BlocSurvey? blocSurvey;
  const PageBelanjaSurvey(this.uiSurvey, this.blocSurvey, {Key? key})
      : super(key: key);
  @override
  _PageBelanjaSurveyState createState() => _PageBelanjaSurveyState();
}

class _PageBelanjaSurveyState extends State<PageBelanjaSurvey> {
  TextEditingController? _telkomselController;
  TextEditingController? _isatController;
  TextEditingController? _xlController;
  TextEditingController? _triController;
  TextEditingController? _smartController;
  TextEditingController? _axisController;
  TextEditingController? _otherController;
  BlocSurvey? _blocSurvey;

  int _countBuild = 0;

  @override
  void initState() {
    _blocSurvey = widget.blocSurvey;
    _telkomselController = TextEditingController();
    _isatController = TextEditingController();
    _xlController = TextEditingController();
    _triController = TextEditingController();
    _smartController = TextEditingController();
    _axisController = TextEditingController();
    _otherController = TextEditingController();
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
    _telkomselController!.text = widget.uiSurvey!.telkomsel == null
        ? ''
        : '${widget.uiSurvey!.telkomsel}';
    _isatController!.text =
        widget.uiSurvey!.isat == null ? '' : '${widget.uiSurvey!.isat}';
    _xlController!.text =
        widget.uiSurvey!.xl == null ? '' : '${widget.uiSurvey!.xl}';
    _triController!.text =
        widget.uiSurvey!.tri == null ? '' : '${widget.uiSurvey!.tri}';
    _smartController!.text =
        widget.uiSurvey!.sf == null ? '' : '${widget.uiSurvey!.sf}';
    _axisController!.text =
        widget.uiSurvey!.axis == null ? '' : '${widget.uiSurvey!.axis}';
    _otherController!.text =
        widget.uiSurvey!.other == null ? '' : '${widget.uiSurvey!.other}';
  }

  @override
  Widget build(BuildContext context) {
    if (_countBuild == 0) {
      _setValue();
      _countBuild++;
    }

    Size s = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.uiSurvey!.isbelanjasubmitted
                ? _successDisubmit()
                : Container(),
            _cardForm(s.width, widget.uiSurvey!.isbelanjasubmitted == false),
            widget.uiSurvey!.pathphotobelanja == null
                ? ButtonStrectWidth(
                    buttonColor: Colors.green,
                    text: "Ambil Foto",
                    onTap: () async {
                      FocusScope.of(context).unfocus();
                      ParamPreviewPhoto params = ParamPreviewPhoto(
                        EnumTakePhoto.marketaudit,
                        pathPhoto: null,
                      );
                      await Navigator.pushNamed(context, CameraView.routeName,
                          arguments: params);

                      String? path =
                          await StoredPathPhoto.getPhotoMarketAudit();
                      print("BELANJA SURVEY: $path");
                      _blocSurvey!.setpathphoto(path);
                    },
                    isenable: true)
                : Container(),
            _showImage(widget.uiSurvey!.pathphotobelanja),
            const SizedBox(
              height: 12,
            ),
            widget.uiSurvey!.isbelanjasubmitted
                ? Container()
                : ButtonStrectWidth(
                    buttonColor: Colors.red,
                    text: "SUBMIT",
                    onTap: () {
                      if (widget.uiSurvey!.isbelanjabisasubmit()) {
                        TgzDialog.loadingDialog(context);
                        _blocSurvey!.submitBelanja().then((value) {
                          Navigator.of(context).pop();
                          if (value) {
                            _confirmSuccessSimpan();
                          } else {
                            _confirmGagalMenyimpan();
                          }
                        });
                      } else {
                        _confirmInputTidakValid();
                      }
                      widget.blocSurvey!.changeTextBelanja(
                          _telkomselController!.text, EnumOperator.telkomsel);
                      widget.blocSurvey!.changeTextBelanja(
                          _isatController!.text, EnumOperator.isat);
                      widget.blocSurvey!.changeTextBelanja(
                          _xlController!.text, EnumOperator.xl);
                      widget.blocSurvey!.changeTextBelanja(
                          _triController!.text, EnumOperator.tri);
                      widget.blocSurvey!.changeTextBelanja(
                          _smartController!.text, EnumOperator.sf);
                      widget.blocSurvey!.changeTextBelanja(
                          _axisController!.text, EnumOperator.axis);
                      widget.blocSurvey!.changeTextBelanja(
                          _otherController!.text, EnumOperator.other);
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

  Widget _cardForm(double width, bool isEnable) {
    double w = width - 150;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _cellForm(w, 'Telkomsel', _telkomselController,
                EnumOperator.telkomsel, isEnable),
            _cellForm(w, 'Isat', _isatController, EnumOperator.isat, isEnable),
            _cellForm(w, 'XL', _xlController, EnumOperator.xl, isEnable),
            _cellForm(w, '3', _triController, EnumOperator.tri, isEnable),
            _cellForm(
                w, 'Smartfren', _smartController, EnumOperator.sf, isEnable),
            _cellForm(w, 'Axis', _axisController, EnumOperator.axis, isEnable),
            _cellForm(
                w, 'Other', _otherController, EnumOperator.other, isEnable),
          ],
        ),
      ),
    );
  }

  Widget _cellForm(
      double width,
      String label,
      TextEditingController? controller,
      EnumOperator enumOperator,
      bool isenable) {
    return Row(
      children: [
        SizedBox(width: 70, child: LabelBlack.size2(label)),
        SizedBox(
          width: 30,
          child: LabelBlack.size1(": Rp"),
        ),
        SizedBox(
            width: width,
            child: TextFieldNumberOnly(
              '',
              controller,
              onChanged: (str) {
                _blocSurvey!.changeTextBelanja(str, enumOperator);
              },
              enable: isenable,
            ))
      ],
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
                  child: widget.uiSurvey!.isbelanjasubmitted
                      ? Image.network(
                          url,
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace? stackTrace) {
                            return Container();
                          },
                        )
                      : Image.file(
                          File(url),
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace? stackTrace) {
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
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0, left: 16.0, bottom: 3.0),
                  child: LabelBlack.size2('Market Audit berhasil disimpan.'),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0, left: 16.0, bottom: 3.0),
                  child: ButtonApp.black('Ok', () {
                    Navigator.of(context).pop();
                    _blocSurvey!.refresh();
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
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0, left: 16.0, bottom: 3.0),
                  child: LabelBlack.size2('Market Audit gagal disimpan.'),
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

  _confirmInputTidakValid() {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => SimpleDialog(
              title: LabelApp.size1(
                'Confirm',
                color: Colors.red,
              ),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0, left: 16.0, bottom: 3.0),
                  child: LabelBlack.size2('Harus lebih dari 1000 rupiah.'),
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
