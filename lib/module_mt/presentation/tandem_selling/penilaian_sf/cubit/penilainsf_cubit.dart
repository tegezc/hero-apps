import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hero/module_mt/data/datasources/tandem/penilaian_sf_datasource.dart';
import 'package:hero/module_mt/data/repositories/penilaian_sf/penilaian_sf_repository.dart';
import 'package:hero/module_mt/domain/entity/tandem_selling/penilaian_sf.dart';
import 'package:hero/module_mt/domain/usecase/tandem_selling/penilaian_sf/penilaian_sf_usecase.dart';

part 'penilainsf_state.dart';

class PenilainsfCubit extends Cubit<PenilainsfState> {
  PenilainsfCubit() : super(PenilainsfInitial());
  late PeniaianSfUsecase peniaianSfUsecase;
  PenilaianSf? cachePenilaianSf;
  void setupData(String idsf) {
    PenilaianSfDataSourceImpl penilaianSfDataSource =
        PenilaianSfDataSourceImpl();
    PenilaianSfRepositoryImpl penilaianSfRepositoryImpl =
        PenilaianSfRepositoryImpl(penilaianSfDataSource);
    peniaianSfUsecase = PeniaianSfUsecase(penilaianSfRepositoryImpl);

    _setupData(idsf).then((value) {
      if (value) {
        emit(PenilainsfLoaded(cachePenilaianSf!));
      } else {
        emit(const PenilainsfError('Ada Kesalahan saat akses server.'));
      }
    });
  }

  Future<bool> _setupData(String idsf) async {
    try {
      cachePenilaianSf = await peniaianSfUsecase.getData(idsf);
      if (cachePenilaianSf == null) {
        return false;
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}
