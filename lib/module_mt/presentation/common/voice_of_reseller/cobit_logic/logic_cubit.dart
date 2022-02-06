import 'package:bloc/bloc.dart';
import 'package:hero/module_mt/data/datasources/voice_of_reseller_datasource.dart';
import 'package:hero/module_mt/domain/usecase/common/voice_of_retailer/submit_vor_usecase.dart';
import 'package:meta/meta.dart';

import '../../../../../core/log/printlog.dart';
import '../../../../data/repositories/voice_of_reseller/voice_of_reseller_repository.dart';
import '../../../../domain/entity/common/voice_of_retailer/jawaban.dart';
import '../../../../domain/entity/common/voice_of_retailer/voice_of_reseller.dart';

part 'logic_state.dart';

class LogicCubit extends Cubit<LogicState> {
  LogicCubit({required this.vor, required this.idOutlet})
      : super(LogicInitial(vor));
  VoiceOfReseller vor;
  final String idOutlet;

  void setCurrentValueCombobox(int index, Jawaban value) {
    ph('change comobo: $value');
    vor.lPertanyaan[index].terpilih = value;
    emit(ChangeCombobox(vor));
  }

  void setVideoPath(String videoPath) {
    vor.pathVideo = videoPath;
    emit(RefreshForSetPathVideo(vor));
  }

  void confirmSubmit() {
    if (vor.isValidToSubmit()) {
      emit(ConfirmSubmit(vor));
    } else {
      emit(AllCommboNotPickedYet(vor));
    }
  }

  void submit() async {
    emit(LoadingSubmitData(vor));
    _prosesSubmit().then((value) {
      if (value) {
        emit(SubmitSuccessOrNot(vor,
            message: 'Data berhasil di submit', isSuccess: true));
      } else {
        emit(SubmitSuccessOrNot(vor,
            message: 'Data gagal di submit', isSuccess: false));
      }
    });
  }

  Future<bool> _prosesSubmit() async {
    VoiceOfResellerDatasourceImpl datasourceImpl =
        VoiceOfResellerDatasourceImpl();
    VoieceOfResellerrRepositoryImpl vorRepository =
        VoieceOfResellerrRepositoryImpl(
            voiceOfResellerDatasource: datasourceImpl);
    SubmitVorUsecase vorUsecase = SubmitVorUsecase(vorRepository);

    return vorUsecase(vor, idOutlet);
  }
}
