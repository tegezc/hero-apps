import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../data/datasources/tandem/penilaian_sf_datasource.dart';
import '../../../../data/repositories/penilaian_sf/penilaian_sf_repository.dart';
import '../../../../domain/entity/tandem_selling/penilaian_sf.dart';
import '../../../../domain/usecase/tandem_selling/penilaian_sf/penilaian_sf_usecase.dart';

part 'page_parent_state.dart';

class PageParentCubit extends Cubit<PageParentPenilaianSFState> {
  PageParentCubit() : super(PageParentPenilaianSFInitial());
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
        emit(PageParentPenilaianSfLoaded(cachePenilaianSf!));
      } else {
        emit(PageParentPenilaianSfError('Ada Kesalahan saat akses server.'));
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
