import 'package:bloc/bloc.dart';
import 'package:hero/module_mt/domain/entity/common/outlet_mt.dart';
import 'package:meta/meta.dart';

import '../../../data/datasources/common/outlet_mt_datasource.dart';
import '../../../data/repositories/common/outletmt_repository.dart';
import '../../../domain/usecase/back_checking/search_back_checking_use_case.dart';

part 'home_back_checking_state.dart';

class HomeBackCheckingCubit extends Cubit<HomeBackCheckingState> {
  HomeBackCheckingCubit() : super(HomeBackCheckingInitial());

  void setupData() {
    emit(HomeBackCheckingLoaded(null));
  }

  void searchOutletMt(String query) async {
    OutletMTDatasourceImpl outletMTDatasource = OutletMTDatasourceImpl();
    OutletMTRepository outletMTRepository =
        OutletMTRepository(outletMTDatasource: outletMTDatasource);
    SearchBackCheckingUseCase sTandem =
        SearchBackCheckingUseCase(outletMTRepository);
    emit(HomeBackCheckingLoading());
    sTandem.getListOutlet(query).then((value) {
      if (value == null) {
        emit(HomeBackCheckingError(
            message: 'Kesulitan mendapatkan data dari server.'));
      } else {
        emit(HomeBackCheckingLoaded(value));
      }
    });
  }
}
