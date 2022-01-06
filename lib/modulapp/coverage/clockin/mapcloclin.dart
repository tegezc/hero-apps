import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hero/database/daoserial.dart';
import 'package:hero/http/coverage/httpdashboard.dart';
import 'package:hero/model/enumapp.dart';
import 'package:hero/model/menu.dart';
import 'package:hero/model/pjp.dart';
import 'package:hero/modulapp/camera/loadingview.dart';
import 'package:hero/modulapp/camera/pagetakephoto.dart';
import 'package:hero/modulapp/coverage/clockin/menusales.dart';
import 'package:hero/util/component/component_button.dart';
import 'package:hero/util/component/component_label.dart';
import 'package:hero/util/component/component_widget.dart';
import 'package:hero/util/constapp/accountcontroller.dart';
import 'package:hero/util/dateutil.dart';
import 'package:hero/util/locationutil.dart';
import 'package:location/location.dart';

class MapClockIn extends StatefulWidget {
  static const routeName = '/mapclockin';
  final Pjp? pjp;
  MapClockIn(this.pjp);
  @override
  _MapClockInState createState() => _MapClockInState();
}

class _MapClockInState extends State<MapClockIn> {
  GoogleMapController? mapController;
  Menu? _menu;
  EnumAccount? _enumAccount;
  double? _hightCell;
  late double _minusWidget;
  List<Marker> lmarkers = [];
  late LatLng _lokasi;
  //
  // LatLng _locSales = const LatLng(-5.398178, 105.264676);
//  LatLng _locSales;

  double _distanceInMeters = 0.0;
  Set<Circle>? circles;
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    print('${widget.pjp!.lat} || ${widget.pjp!.long}');
    _lokasi = LatLng(widget.pjp!.lat!, widget.pjp!.long!);
    lmarkers.add(Marker(
        markerId: MarkerId('location'),
        draggable: false,
        onTap: () {
          print('mark di klik');
        },
        position: _lokasi));
    super.initState();
    _setup();
  }

  void _setup() {
    _setupLocation().then((value) {
      print(value);
      setState(() {});
    });
  }

  Future<EnumStatusTempat?> _getStatusClockInOpenOrClose() async {
    HttpDashboard httpDashboard = HttpDashboard();
    _menu = await httpDashboard.getMenu();
    return _menu?.enumStatusTempat;
  }

  Future<bool> _setupLocation() async {
    // Position position = await Geolocator.getCurrentPosition(
    //     desiredAccuracy: LocationAccuracy.high);
    LocationData position = await LocationUtil.getCurrentLocation();
    print('current location : $position');
    // distanceInMeters = Geolocator.distanceBetween(
    //     position.latitude, position.longitude, widget.pjp.lat, widget.pjp.long);
    _distanceInMeters = Geolocator.distanceBetween(position.latitude!,
        position.longitude!, _lokasi.latitude, _lokasi.longitude);

    EnumAccount enumAccount = await AccountHore.getAccount();
    _enumAccount = enumAccount;
    _hightCell =
        enumAccount == EnumAccount.sf ? _hightCell = 123 : _hightCell = 100;
    _minusWidget =
        enumAccount == EnumAccount.sf ? _minusWidget = 211 : _minusWidget = 181;

    //  LatLng locSales = LatLng(position.latitude, position.longitude);
    // circles = Set.from([
    //   Circle(
    //     circleId: CircleId('currentlocation'),
    //     center: locSales,
    //     radius: 1,
    //     fillColor: Colors.blue,
    //     strokeWidth: 1,
    //   )
    // ]);

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
    bool _isbuttonEnable = _distanceInMeters <= radius!;
    return CustomScaffold(
      body: Container(
        height: size.height,
        width: size.width,
        child: Column(
          children: [
            Container(
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
              height: _hightCell,
              width: size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _enumAccount == EnumAccount.sf ? _cellSF() : _cellDs(),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: ButtonStrectWidth(
                      buttonColor: Colors.red,
                      text:
                          'Clock In : Radius ( ${_distanceInMeters.toInt()} m ) - Radius($radius)',
                      onTap: () {
                        _buttonClockInOnClick();
                      },
                      isenable: _isbuttonEnable,
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

  void _buttonClockInOnClick() {
    TgzDialog.loadingDialog(context);
    _getStatusClockInOpenOrClose().then((value) {
      Navigator.of(context).pop();
      if (value != null) {
        if (value == EnumStatusTempat.open) {
          _gotoMenu();
        } else if (value == EnumStatusTempat.close) {
          _takePhoto();
        } else {
          _showDialogConfirmClockin();
        }
      }
    });
  }

  Future<bool> _clockin(EnumStatusTempat enumStatusTempat) async {
    HttpDashboard httpdashboard = new HttpDashboard();
    String? value = await httpdashboard.clockin(widget.pjp!, enumStatusTempat);
    print(value);
    if (value != null) {
      AccountHore.setIdHistoryPjp(value);
      DaoSerial daoSerial = new DaoSerial();
      int res = await daoSerial.deleteAllSerial();
      if (res > 0) {}
      return true;
    }

    return false;
  }

  Widget _cellSF() {
    String strTgl = DateUtility.dateToStringLengkap(DateTime.now());
    return Column(
      children: [
        // Padding(
        //   padding: const EdgeInsets.only(top: 4, bottom: 0),
        //   child: LabelBlack.size3('$distanceInMeters'),
        // ),
        Padding(
          padding: const EdgeInsets.only(top: 5.0, bottom: 0),
          child: LabelBlack.size2(widget.pjp!.tempat!.id),
        ),
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

  _showDialogConfirmClockin() {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => SimpleDialog(
              title: Text('Confirm'),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: LabelApp.size2(
                      'Pilih kondisi PJP, apakah open atau close?'),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0, left: 16.0, bottom: 3.0),
                  child: ButtonApp.black('OPEN', () {
                    _prosesOpen();
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0, left: 16.0, bottom: 3.0),
                  child: ButtonApp.black('CLOSE', () {
                    _prosesClose();
                  }),
                ),
              ],
            ));
  }

  void _prosesOpen() {
    _clockin(EnumStatusTempat.open).then((value) {
      if (value) {
        Navigator.of(context).pop();
        _gotoMenu();
      }
    });
  }

  void _prosesClose() {
    _clockin(EnumStatusTempat.close).then((value) {
      if (value) {
        Navigator.of(context).pop();
        _takePhoto();
      }
    });
  }

  void _gotoMenu() {
    Navigator.pushNamed(context, MenuSales.routeName, arguments: widget.pjp);
  }

  void _takePhoto() {
    Navigator.pushNamed(
      context,
      CameraView.routeName,
      arguments: ParamPreviewPhoto(EnumTakePhoto.distibusiclose),
    );
  }
}
