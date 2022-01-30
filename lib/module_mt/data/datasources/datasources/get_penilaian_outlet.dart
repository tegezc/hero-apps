import 'package:flutter/cupertino.dart';
import 'package:hero/module_mt/domain/entity/tandem_selling/penilaian_outlet/advokasi.dart';
import 'package:hero/module_mt/domain/entity/tandem_selling/penilaian_outlet/availability.dart';

abstract class GetPenilaianOutlet {
  Future<Availability> getAvailability();
  Future<Visibility> getVisibility();
  Future<Advokasi> getAdvokasi();
}

class GetPenilaianOutletRemote implements GetPenilaianOutlet {
  @override
  Future<Advokasi> getAdvokasi() {
    // TODO: implement getAdvokasi
    throw UnimplementedError();
  }

  @override
  Future<Availability> getAvailability() {
    // TODO: implement getAvailability
    throw UnimplementedError();
  }

  @override
  Future<Visibility> getVisibility() {
    // TODO: implement getVisibility
    throw UnimplementedError();
  }
}
