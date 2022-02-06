import 'package:hero/module_mt/domain/entity/common/voice_of_retailer/pertanyaan.dart';

class VoiceOfReseller {
  List<Pertanyaan> lPertanyaan;
  String? pathVideo;
  VoiceOfReseller({required this.lPertanyaan, this.pathVideo});

  bool isValidToSubmit() {
    if (pathVideo == null) {
      return false;
    }
    for (int i = 0; i < lPertanyaan.length; i++) {
      if (lPertanyaan[i].terpilih == null) {
        return false;
      }
    }
    return true;
  }
}
