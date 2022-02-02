import 'package:hero/module_mt/data/datasources/voice_of_reseller_datasource.dart';
import 'package:hero/module_mt/domain/entity/common/voice_of_retailer/voice_of_reseller.dart';
import 'package:hero/module_mt/domain/repositories/voice_of_reseller/i_voice_of_reseller_repository.dart';

class VoieceOfResserRepositoryImpl implements IVoiceOfResellerRepository {
  IVoiceOfResellerDatasource voiceOfResellerDatasource;
  VoieceOfResserRepositoryImpl({required this.voiceOfResellerDatasource});
  @override
  Future<VoiceOfReseller?> getVoiceOfReseller(String idOutlet) {
    return voiceOfResellerDatasource.getData(idOutlet);
  }
}
