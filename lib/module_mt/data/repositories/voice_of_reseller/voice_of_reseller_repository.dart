import 'package:hero/module_mt/data/datasources/voice_of_reseller_datasource.dart';
import 'package:hero/module_mt/domain/entity/common/voice_of_retailer/voice_of_reseller.dart';
import 'package:hero/module_mt/domain/repositories/voice_of_reseller/i_voice_of_reseller_repository.dart';

class VoieceOfResellerrRepositoryImpl implements IVoiceOfResellerRepository {
  IVoiceOfResellerDatasource voiceOfResellerDatasource;
  VoieceOfResellerrRepositoryImpl({required this.voiceOfResellerDatasource});
  @override
  Future<VoiceOfReseller?> getVoiceOfReseller(String idOutlet) {
    return voiceOfResellerDatasource.getData(idOutlet);
  }

  @override
  Future<bool> submit(VoiceOfReseller vor, String idOutlet) {
    return voiceOfResellerDatasource.submit(vor, idOutlet);
  }
}
