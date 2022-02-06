import 'package:hero/module_mt/domain/entity/common/voice_of_retailer/voice_of_reseller.dart';

abstract class IVoiceOfResellerRepository {
  Future<VoiceOfReseller?> getVoiceOfReseller(String idOutlet);
  Future<bool> submit(VoiceOfReseller vor, String idOutlet);
}
