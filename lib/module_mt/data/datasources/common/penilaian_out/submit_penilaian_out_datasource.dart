import 'package:dio/dio.dart';
import 'package:hero/module_mt/data/datasources/core/dio_config.dart';
import 'package:hero/module_mt/data/model/common/penilaian_outlet/advokasi_model.dart';
import 'package:hero/module_mt/data/model/common/penilaian_outlet/availability_model.dart';
import 'package:hero/module_mt/data/model/common/penilaian_outlet/visibility_model.dart';
import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/advokasi.dart';
import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/availability.dart';
import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/visibility.dart';
import 'package:hero/util/numberconverter.dart';

abstract class ISubmitPenilaianOutDatasource {
  Future<bool> submitAvailability(Availability availability, String idOutlet);
  Future<bool> submitVisibility(
      PenilaianVisibility visibility, String idOutlet);
  Future<bool> submitAdvokat(Advokasi advokasi, String idOutlet);
}

class SubmitPenilaianOutDatasourceImpl
    implements ISubmitPenilaianOutDatasource {
  @override
  Future<bool> submitAdvokat(Advokasi advokasi, String idOutlet) async {
    Map<String, dynamic> ad = AdvokasiModel(advokasi).toMapForSubmit(idOutlet);

    GetDio getDio = GetDio();
    Dio dio = await getDio.dioForm();
    var formData = FormData.fromMap(ad);
    var response =
        await dio.post('/penilaianoutlet/kirim_advokasi', data: formData);
    return _olahJsonResponseSubmit(response.data);
  }

  @override
  Future<bool> submitAvailability(
      Availability availability, String idOutlet) async {
    Map<String, dynamic> avm =
        AvailabilityModel(availability).toMapForSubmit(idOutlet);
    GetDio getDio = GetDio();
    Dio dio = await getDio.dioForm();
    var formData = FormData.fromMap(avm);
    var response =
        await dio.post('/penilaianoutlet/kirim_availability', data: formData);
    return _olahJsonResponseSubmit(response.data);
  }

  bool _olahJsonResponseSubmit(dynamic json) {
    try {
      Map<String, dynamic> map = json;
      if (map['status'] != null) {
        int? status = ConverterNumber.stringToIntOrNull(map['status']);
        if (status == null) {
          return false;
        } else if (status == 1) {
          return true;
        }
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> submitVisibility(
      PenilaianVisibility visibility, String idOutlet) async {
    Map<String, dynamic> avm =
        VisibilityModel(visibility).toMapForSubmit(idOutlet);

    GetDio getDio = GetDio();
    Dio dio = await getDio.dioForm();
    var formData = FormData.fromMap(avm);
    var response =
        await dio.post('/penilaianoutlet/kirim_visibility', data: formData);
    return _olahJsonResponseSubmit(response.data);
  }
}
