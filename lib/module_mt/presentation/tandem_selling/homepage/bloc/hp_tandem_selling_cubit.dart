import 'package:bloc/bloc.dart';
import 'package:hero/module_mt/domain/usecase/tandem_selling/prepare_tandem_selling_use_case.dart';
import 'package:meta/meta.dart';

part 'hp_tandem_selling_state.dart';

class HpTandemSellingCubit extends Cubit<HpTandemSellingState> {
  HpTandemSellingCubit() : super(HpTandemSellingInitial());
  late PrepareTandemSellingUseCase prepareTandemSellingUseCase;

  void setupData() {
    // prepareTandemSellingUseCase = PrepareTandemSellingUseCase(comboboxRepository: comboboxRepository);
  }

  // Future<void> _setupData() {
  //
  // }
}
