import 'package:hero/module_mt/domain/entity/common/voice_of_retailer/voice_of_reseller.dart';
import 'package:hero/module_mt/domain/repositories/voice_of_reseller/i_voice_of_reseller_repository.dart';

class GetDataVoiceOfRetailerUseCase {
  IVoiceOfResellerRepository voiceOfResellerRepository;

  GetDataVoiceOfRetailerUseCase({required this.voiceOfResellerRepository});

  Future<VoiceOfReseller?> getData(String idOutlet) async {
    return voiceOfResellerRepository.getVoiceOfReseller(idOutlet);
  }
}
