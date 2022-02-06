import 'package:bloc/bloc.dart';
import 'package:hero/module_mt/domain/entity/tandem_selling/penilaian_sf.dart';
import 'package:hero/module_mt/domain/entity/tandem_selling/static_nilai_sf.dart';
import 'package:hero/module_mt/presentation/tandem_selling/penilaian_sf/enum_penilaian_sf.dart';

part 'penilainsf_state.dart';

class PenilainsfCubit extends Cubit<PenilainsfState> {
  PenilainsfCubit({required this.cachePenilaianSf})
      : super(PenilainsfInitial(cachePenilaianSf));
  PenilaianSf cachePenilaianSf;

  void changeCombobox(EPenilaianSF ePenilaianSF, int index, NilaiSf value) {
    switch (ePenilaianSF) {
      case EPenilaianSF.personalities:
        cachePenilaianSf.personalities[index].nilai = value;
        break;
      case EPenilaianSF.distribution:
        cachePenilaianSf.distribution[index].nilai = value;
        break;
      case EPenilaianSF.merchandising:
        cachePenilaianSf.merchandising[index].nilai = value;
        break;
      case EPenilaianSF.promotion:
        cachePenilaianSf.promotion[index].nilai = value;
        break;
    }

    emit(PenilaianSFRefresh(cachePenilaianSf));
  }
}
