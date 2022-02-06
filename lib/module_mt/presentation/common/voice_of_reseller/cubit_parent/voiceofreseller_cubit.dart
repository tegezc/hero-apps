import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hero/module_mt/data/datasources/voice_of_reseller_datasource.dart';
import 'package:hero/module_mt/data/repositories/voice_of_reseller/voice_of_reseller_repository.dart';
import 'package:hero/module_mt/domain/entity/common/voice_of_retailer/voice_of_reseller.dart';
import 'package:hero/module_mt/domain/usecase/common/voice_of_retailer/get_data_voice_of_r.dart';

part 'voiceofreseller_state.dart';

class VoiceofresellerCubit extends Cubit<VoiceofresellerState> {
  VoiceofresellerCubit() : super(VoiceofresellerInitial());

  late GetDataVoiceOfRetailerUseCase getDataVoiceOfRetailerUseCase;
  void setupData(String idOutlet) {
    VoiceOfResellerDatasourceImpl voiceOfResellerDatasource =
        VoiceOfResellerDatasourceImpl();
    VoieceOfResellerrRepositoryImpl voiceOfResellerRepository =
        VoieceOfResellerrRepositoryImpl(
            voiceOfResellerDatasource: voiceOfResellerDatasource);
    getDataVoiceOfRetailerUseCase = GetDataVoiceOfRetailerUseCase(
        voiceOfResellerRepository: voiceOfResellerRepository);
    _setupData(idOutlet).then((value) {
      if (value != null) {
        emit(VoiceofresellerLoaded(voiceOfReseller: value));
      } else {
        emit(const VoiceofresellerError(message: 'Terjadi Kesalahan'));
      }
    });
  }

  Future<VoiceOfReseller?> _setupData(String idOutlet) async {
    return await getDataVoiceOfRetailerUseCase.getData(idOutlet);
  }
}
