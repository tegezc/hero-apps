import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hero/config/configuration_sf.dart';
import 'package:hero/core/log/printlog.dart';
import 'package:hero/module_mt/data/datasources/voice_of_reseller_datasource.dart';
import 'package:hero/module_mt/data/repositories/voice_of_reseller/voice_of_reseller_repository.dart';
import 'package:hero/module_mt/domain/entity/common/voice_of_retailer/jawaban.dart';
import 'package:hero/module_mt/domain/entity/common/voice_of_retailer/voice_of_reseller.dart';
import 'package:hero/module_mt/domain/usecase/tandem_selling/voice_of_retailer/get_data_voice_of_r.dart';

part 'voiceofreseller_state.dart';

class VoiceofresellerCubit extends Cubit<VoiceofresellerState> {
  VoiceofresellerCubit() : super(VoiceofresellerInitial());

  late GetDataVoiceOfRetailerUseCase getDataVoiceOfRetailerUseCase;
  VoiceOfReseller? cacheVoiceOfReseller;
  void setupData(String idOutlet) {
    VoiceOfResellerDatasourceImpl voiceOfResellerDatasource =
        VoiceOfResellerDatasourceImpl();
    VoieceOfResserRepositoryImpl voiceOfResellerRepository =
        VoieceOfResserRepositoryImpl(
            voiceOfResellerDatasource: voiceOfResellerDatasource);
    getDataVoiceOfRetailerUseCase = GetDataVoiceOfRetailerUseCase(
        voiceOfResellerRepository: voiceOfResellerRepository);
    _setupData(idOutlet).then((value) {
      if (value) {
        emit(VoiceofresellerLoaded(voiceOfReseller: cacheVoiceOfReseller));
      } else {
        emit(const VoiceofresellerError(message: 'Terjadi Kesalahan'));
      }
    });
  }

  Future<bool> _setupData(String idOutlet) async {
    cacheVoiceOfReseller =
        await getDataVoiceOfRetailerUseCase.getData(idOutlet);
    if (cacheVoiceOfReseller != null) {
      return true;
    }
    return false;
  }

  void setCurrentValueCombobox(int index, Jawaban value) {
    ph('change comobo: $value');
    cacheVoiceOfReseller!.lPertanyaan[index].terpilih = value;
    //emit(VoiceofresellerLoaded(voiceOfReseller: cacheVoiceOfReseller));
  }
}
