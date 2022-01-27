import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'hp_tandem_selling_state.dart';

class HpTandemSellingCubit extends Cubit<HpTandemSellingState> {
  HpTandemSellingCubit() : super(HpTandemSellingInitial());
}
