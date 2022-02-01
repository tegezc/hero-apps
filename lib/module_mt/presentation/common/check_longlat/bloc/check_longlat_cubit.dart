import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hero/config/configuration_sf.dart';
import 'package:hero/core/domain/entities/tgzlocation.dart';
import 'package:hero/module_mt/domain/entity/common/outlet_mt.dart';
import 'package:hero/core/data/datasources/location/tgz_location.dart';
import 'package:hero/util/numberconverter.dart';
import 'package:meta/meta.dart';

part 'check_longlat_state.dart';

const validRadius = 100;

class CheckLonglatCubit extends Cubit<CheckLonglatState> {
  CheckLonglatCubit() : super(CheckLonglatInitial());

  void setup(OutletMT outletMT) {
    emit(CheckLonglatInitial());
    if (outletMT.location != null) {
      _handlePjpValid(locationData: outletMT.location!).then((_) {});
    }
  }

  Future<void> _handlePjpValid({required TgzLocationData locationData}) async {
    List<Marker> lmarkers = [];
    LatLng _lokasi = LatLng(locationData.latitude, locationData.longitude);
    ph('Hallo');
    TgzLocationData? position =
        await TgzLocationDataSourceImpl().getCurrentLocationOrNull();
    ph(position);
    if (position == null) {
      emit(CheckLonglatError(message: 'Tidak dapat mengakses location.'));
    } else {
      lmarkers.add(Marker(
          markerId: const MarkerId('location'),
          draggable: false,
          onTap: () {},
          position: _lokasi));
      double distanceInMeters = Geolocator.distanceBetween(position.latitude,
          position.longitude, locationData.latitude, locationData.longitude);
      String distanceFormat =
          ConverterNumber.getCurrentcy(distanceInMeters.toInt());

      emit(CheckLongLatLoaded(
          isValid: distanceInMeters <= validRadius,
          validRadius: '$validRadius',
          currentRadius: distanceFormat,
          lmarkers: lmarkers,
          lokasiOutlet: _lokasi));
    }
  }
}
