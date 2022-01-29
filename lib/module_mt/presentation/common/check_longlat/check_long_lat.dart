import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hero/model/enumapp.dart';
import 'package:hero/module_mt/domain/entity/outlet_mt.dart';
import 'package:hero/module_mt/presentation/common/widgets/PageErrorWithRefresh.dart';
import 'package:hero/util/component/widget/component_widget.dart';

import 'bloc/check_longlat_cubit.dart';

class CheckLongLat extends StatefulWidget {
  static const routeName = '/ceklonglat';
  final OutletMT outletMt;
  const CheckLongLat(this.outletMt, {Key? key}) : super(key: key);
  @override
  _CheckLongLatState createState() => _CheckLongLatState();
}

class _CheckLongLatState extends State<CheckLongLat> {
  GoogleMapController? mapController;

  Set<Circle>? circles;
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  EnumStateWidget enumStateWidget = EnumStateWidget.loading;
  final CheckLonglatCubit _bloc = CheckLonglatCubit();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<CheckLonglatCubit, CheckLonglatState>(
        bloc: _bloc..setup(widget.outletMt),
        builder: (context, state) {
          if (state is CheckLonglatInitial) {
            return ScaffoldMT(body: Container(), title: 'Loading..');
          }

          if (state is CheckLonglatError) {
            CheckLonglatError checkLonglatError = state;
            return PageErrorWithRefresh(
              message: checkLonglatError.message,
              onRefresh: () {
                _bloc.setup(widget.outletMt);
              },
            );
          }

          if (state is CheckLongLatLoaded) {
            CheckLongLatLoaded checkLongLatLoaded = state;
            return CustomScaffold(
              body: SizedBox(
                height: size.height,
                width: size.width,
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height - 170,
                      width: size.width,
                      child: GoogleMap(
                        myLocationEnabled: true,
                        myLocationButtonEnabled: true,
                        markers: Set.from(checkLongLatLoaded.lmarkers),
                        onMapCreated: _onMapCreated,
                        initialCameraPosition: CameraPosition(
                          target: checkLongLatLoaded.lokasiOutlet,
                          zoom: 18.0,
                        ),
                        //    circles: circles,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Card(
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 8,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0),
                                child: _richText(
                                    checkLongLatLoaded.isValid,
                                    checkLongLatLoaded.currentRadius,
                                    checkLongLatLoaded.validRadius),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              title: 'Map Clock In',
            );
          }

          return PageErrorWithRefresh(
            message: 'Error',
            onRefresh: () {},
          );
        });
  }

  Widget _richText(bool isValid, String currentLoc, String validRad) {
    String s1 = 'Lokasi Outlet ';
    String s2 = '';
    String s3 =
        ', Jarak Anda dengan outlet adalah  $currentLoc m, Batas valid adalah $validRad m';
    if (isValid) {
      s2 = 'VALID';
    } else {
      s2 = 'TIDAK VALID';
    }
    TextStyle _textstyle1 = const TextStyle(
        color: Colors.black, fontSize: 14, fontWeight: FontWeight.normal);

    TextStyle _textstyle2 = const TextStyle(
        color: Colors.red, fontSize: 15, fontWeight: FontWeight.bold);
    return RichText(
      text: TextSpan(
        text: s1,
        style: _textstyle1,
        children: <TextSpan>[
          TextSpan(text: s2, style: _textstyle2),
          TextSpan(text: s3, style: _textstyle1)
        ],
      ),
    );
  }
}
