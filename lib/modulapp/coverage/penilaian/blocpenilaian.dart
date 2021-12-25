import 'package:hero/model/penilaian.dart';

enum EnumPenilaian { personality, distribusi, merchandising, promotion }

class ItemPenilaian {
  List<MPenilaian>? lpersonality;
  List<MPenilaian>? ldistribusi;
  List<MPenilaian>? lmerchandising;
  List<MPenilaian>? lpromotion;
  ItemPenilaian.empty() {
    lpersonality = [];
    ldistribusi = [];
    lmerchandising = [];
    lpromotion = [];

    lpersonality!.add(MPenilaian('Attendance', 0, 0, 0));
    lpersonality!.add(MPenilaian('Comunication', 0, 0, 0));
    lpersonality!.add(MPenilaian('Honesty', 0, 0, 0));
    lpersonality!.add(MPenilaian('Service', 0, 0, 0));

    ldistribusi!.add(MPenilaian('SA Availability', 0, 0, 0));
    ldistribusi!.add(MPenilaian('Voucher Fisik Availability', 0, 0, 0));
    ldistribusi!.add(MPenilaian('LinkAja Availability', 0, 0, 0));

    lmerchandising!.add(MPenilaian('Poster Share', 0, 0, 0));
    lmerchandising!.add(MPenilaian('Etalase Share', 0, 0, 0));
    lmerchandising!.add(MPenilaian('Spanduk Share', 0, 0, 0));

    lpromotion!.add(MPenilaian('Clear Socialization', 0, 0, 0));
    lpromotion!.add(MPenilaian('Update Product/Sales Program', 0, 0, 0));
  }
}
