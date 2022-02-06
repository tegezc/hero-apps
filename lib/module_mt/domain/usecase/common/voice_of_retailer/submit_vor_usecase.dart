import 'package:hero/module_mt/domain/entity/common/voice_of_retailer/voice_of_reseller.dart';
import 'package:hero/module_mt/domain/repositories/voice_of_reseller/i_voice_of_reseller_repository.dart';

class SubmitVorUsecase {
  IVoiceOfResellerRepository vorRepository;
  SubmitVorUsecase(this.vorRepository);
  Future<bool> call(VoiceOfReseller vor, String idOutlet) async {
    return await vorRepository.submit(vor, idOutlet);
  }
}
