import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hero/configuration.dart';
import 'package:hero/model/enumapp.dart';
import 'package:hero/model/pjp.dart';
import 'package:hero/modulapp/camera/pagetakephoto.dart';
import 'package:hero/modulapp/coverage/clockin/clcokinclockoutcontroller.dart';
import 'package:hero/modulapp/coverage/clockin/menusales.dart';
import 'package:hero/util/component/button/component_button.dart';
import 'package:hero/util/component/label/component_label.dart';
import 'package:hero/util/component/tgzdialog.dart';
import 'package:hero/util/component/widget/component_widget.dart';
import 'package:hero/util/constapp/accountcontroller.dart';
import 'package:hero/util/dateutil.dart';
import 'package:hero/util/locationutil.dart';
import 'package:location/location.dart';

class MapClockIn extends StatefulWidget {
  static const routeName = '/mapclockin';
  final Pjp? pjp;
  const MapClockIn(this.pjp, {Key? key}) : super(key: key);
  @override
  _MapClockInState createState() => _MapClockInState();
}

class _MapClockInState extends State<MapClockIn> {
  GoogleMapController? mapController;

  EnumAccount? _enumAccount;
  double _minusWidget = 250.0;
  List<Marker> lmarkers = [];
  late LatLng _lokasi;
  late final ClockInClockOutController _clockInClockOutController;

  EnumStatusTempat? _valueRadioButton;
  Configuration _configuration = Configuration();

  double _distanceInMeters = 0.0;
  Set<Circle>? circles;
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    _lokasi = LatLng(widget.pjp!.lat!, widget.pjp!.long!);
    _clockInClockOutController = ClockInClockOutController();
    lmarkers.add(Marker(
        markerId: const MarkerId('location'),
        draggable: false,
        onTap: () {},
        position: _lokasi));
    super.initState();
    _setup();
  }

  void _setup() {
    _setupLocation().then((value) {
      setState(() {});
    });
  }

  Future<bool> _setupLocation() async {
    LocationData position = await LocationUtil.getCurrentLocation();

    _distanceInMeters = Geolocator.distanceBetween(position.latitude!,
        position.longitude!, _lokasi.latitude, _lokasi.longitude);

    _enumAccount = await AccountHore.getAccount();

    return true;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (_enumAccount == null
        //|| circles == null
        ) {
      return CustomScaffold(
        body: Container(),
        title: '',
      );
    }
    int? radius = 0;
    if (widget.pjp != null && widget.pjp?.radius != null) {
      radius = widget.pjp?.radius;
    }
    // bool _isbuttonEnable = _distanceInMeters <= radius!;

    String textButton =
        'Clock In : Radius ( ${_distanceInMeters.toInt()} m ) - Max($radius)';
    bool isShowRadio = true;
    EnumStatusClockIn? statusClockIn = _getStatusClockInOpenOrClose();
    if (statusClockIn != null) {
      if (statusClockIn == EnumStatusClockIn.open) {
        textButton =
            "Ke Menu : Radius ( ${_distanceInMeters.toInt()} m ) - Max($radius)";
      } else if (statusClockIn == EnumStatusClockIn.close) {
        textButton =
            "Ambil Photo : Radius ( ${_distanceInMeters.toInt()} m ) - Max($radius)";
      }

      if (statusClockIn == EnumStatusClockIn.open ||
          statusClockIn == EnumStatusClockIn.close) {
        isShowRadio = false;
        _minusWidget = _minusWidget - 65;
      }
    }

    return CustomScaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Column(
          children: [
            SizedBox(
              height: size.height - _minusWidget,
              width: size.width,
              child: GoogleMap(
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                markers: Set.from(lmarkers),
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _lokasi,
                  zoom: 18.0,
                ),
                //    circles: circles,
              ),
            ),
            Container(
              color: Colors.white,
              // height: 400,
              width: size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  isShowRadio ? _radioButtonGroup() : Container(),
                  const SizedBox(
                    height: 8,
                  ),
                  _enumAccount == EnumAccount.sf ? _cellSF() : _cellDs(),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: ButtonStrectWidth(
                      buttonColor: Colors.red,
                      text: textButton,
                      onTap: () {
                        _buttonClockInOnClick();
                      },
                      isenable: _configuration.radiusClockin(
                          maxradius: radius, actualradius: _distanceInMeters),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      title: 'Map Clock In',
    );
  }

  Widget _radioButtonGroup() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(left: 50.0, right: 10.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: _itemRadio(EnumStatusTempat.open),
                ),
                Expanded(
                  flex: 1,
                  child: _itemRadio(EnumStatusTempat.close),
                ),
              ],
            ),
          ),
        ),
        const Divider(),
      ],
    );
  }

  Widget _itemRadio(EnumStatusTempat enumStatusTempat) {
    String text = enumStatusTempat == EnumStatusTempat.close ? "Close" : "Open";
    return Row(
      children: [
        Radio<EnumStatusTempat>(
          value: enumStatusTempat,
          groupValue: _valueRadioButton,
          onChanged: (EnumStatusTempat? value) {
            setState(() {
              _valueRadioButton = value;
            });
          },
        ),
        LabelBlack.size1(text),
      ],
    );
  }

  Widget _cellSF() {
    String strTgl = DateUtility.dateToStringLengkap(DateTime.now());
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 4.0, bottom: 0),
          child: LabelBlack.size2(widget.pjp!.tempat!.nama),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
          child: LabelBlack.size2(strTgl),
        ),
      ],
    );
  }

  Widget _cellDs() {
    String strTgl = DateUtility.dateToStringLengkap(DateTime.now());
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 0.0, bottom: 0),
          child: LabelBlack.size2(widget.pjp!.tempat!.nama),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
          child: LabelBlack.size2(strTgl),
        ),
      ],
    );
  }

  _showDialogOpen() {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => SimpleDialog(
              title: const Text('Confirm'),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: LabelApp.size2('Anda memilih open, anda yakin ?'),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0, left: 16.0, bottom: 3.0),
                  child: ButtonApp.black('TEMPAT OPEN', () {
                    Navigator.of(context).pop();
                    _prosesOpen();
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0, left: 16.0, bottom: 3.0),
                  child: ButtonApp.black('CANCEL', () {
                    Navigator.of(context).pop();
                  }),
                ),
              ],
            ));
  }

  _showDialogConfirmNotPickYet() {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => SimpleDialog(
              title: const Text('Confirm'),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: LabelApp.size2(
                      'Anda belum menentukan status tempat di radio button.'),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0, left: 16.0, bottom: 3.0),
                  child: ButtonApp.black('CANCEL', () {
                    Navigator.of(context).pop();
                  }),
                ),
              ],
            ));
  }

  _showDialogClose() {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => SimpleDialog(
              title: const Text('Confirm'),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: LabelApp.size2('Anda memilih Close, anda yakin?'),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0, left: 16.0, bottom: 3.0),
                  child: ButtonApp.black('TEMPAT CLOSE', () {
                    Navigator.of(context).pop();
                    _prosesClose();
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0, left: 16.0, bottom: 3.0),
                  child: ButtonApp.black('CANCEL', () {
                    Navigator.of(context).pop();
                  }),
                ),
              ],
            ));
  }

  void _buttonClockInOnClick() {
    EnumStatusClockIn? statusClockIn = _getStatusClockInOpenOrClose();
    if (statusClockIn != null) {
      if (statusClockIn == EnumStatusClockIn.open) {
        _gotoMenu();
        //_prosesOpen();
      } else if (statusClockIn == EnumStatusClockIn.close) {
        _takePhoto();
      } else if (statusClockIn == EnumStatusClockIn.belum) {
        if (_valueRadioButton == null) {
          _showDialogConfirmNotPickYet();
        } else {
          if (_valueRadioButton == EnumStatusTempat.close) {
            _showDialogClose();
          } else if (_valueRadioButton == EnumStatusTempat.open) {
            _showDialogOpen();
          }
        }
      }
    }
  }

  EnumStatusClockIn? _getStatusClockInOpenOrClose() {
    if (widget.pjp?.status != null) {
      String? status = widget.pjp?.status;
      if (status == "OPEN" || status == "START") {
        return EnumStatusClockIn.open;
      } else if (status == "CLOSE") {
        return EnumStatusClockIn.close;
      }
    } else {
      return EnumStatusClockIn.belum;
    }

    return null;
  }

  void _prosesOpen() {
    TgzDialog.loadingDialog(context);
    _clockInClockOutController
        .clockin(EnumStatusTempat.open, widget.pjp!)
        .then((value) {
      if (value) {
        Navigator.of(context).pop();
        _gotoMenu();
      }
    });
  }

  void _prosesClose() {
    _takePhoto();
  }

  void _gotoMenu() {
    Navigator.pushNamed(context, MenuSales.routeName, arguments: widget.pjp);
  }

  void _takePhoto() {
    Navigator.pushNamed(
      context,
      CameraView.routeName,
      arguments:
          ParamPreviewPhoto(EnumTakePhoto.distibusiclose, pjp: widget.pjp),
    );
  }
}
