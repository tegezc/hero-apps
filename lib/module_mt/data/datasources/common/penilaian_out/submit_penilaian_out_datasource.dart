import 'package:dio/dio.dart';
import 'package:hero/module_mt/data/datasources/core/dio_config.dart';
import 'package:hero/module_mt/data/model/common/penilaian_outlet/availability_model.dart';
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
  Future<bool> submitAdvokat(Advokasi advokasi, String idOutlet) {
    // TODO: implement submitAdvokat
    throw UnimplementedError();
  }

  @override
  Future<bool> submitAvailability(
      Availability availability, String idOutlet) async {
    Map<String, dynamic> avm = AvailabilityModel(availability).toMap(idOutlet);
    avm['myfile1'] = availability.pathPhotoOperator;
    avm['myfile2'] = availability.pathPhotoVF;
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
      PenilaianVisibility visibility, String idOutlet) {
    // TODO: implement submitVisibility
    throw UnimplementedError();
  }
}
