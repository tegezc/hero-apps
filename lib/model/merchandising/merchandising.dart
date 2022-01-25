import 'package:hero/model/pjp.dart';
import 'package:hero/modulapp/camera/preferencephoto.dart';
import 'package:hero/util/numberconverter.dart';

class Merchandising {
  static String tagBackdrop = 'BACKDROP';
  static String tagPerdana = 'PERDANA';
  static String tagVoucherFisik = 'VOUCHER_FISIK';
  static String tagPapan = 'PAPAN_NAMA';
  static String tagPoster = 'POSTER';
  static String tagSpanduk = 'SPANDUK';

  int? telkomsel;
  int? isat;
  int? xl;
  int? tri;
  int? sf;
  int? axis;
  int? other;
  Pjp? pjp;
  String? idjenisshare;
  String? pathPhoto1;
  String? pathPhoto2;
  String? pathPhoto3;

  late bool isServerExist;

  @override
  String toString() {
    return '$telkomsel | $isat | $xl | $tri | $sf | $axis | $other '
        '\n photo1 :$pathPhoto1'
        '\n photo2 :$pathPhoto2'
        '\n photo3 :$pathPhoto3';
  }

  bool isTakePhotoShowing() {
    if (isServerExist) {
      return false;
    }
    return pathPhoto1 == null || pathPhoto2 == null || pathPhoto3 == null;
  }

  bool isvalidtakephoto() {
    if (telkomsel == 0 &&
        isat == 0 &&
        xl == 0 &&
        tri == 0 &&
        sf == 0 &&
        axis == 0 &&
        other == 0) return false;
    return true;
  }

  bool isvalidtosubmit() {
    if (telkomsel == null ||
        isat == null ||
        xl == null ||
        tri == null ||
        sf == null ||
        axis == null ||
        other == null ||
        pathPhoto1 == null) return false;
    return true;
  }

  Merchandising.kosong(this.pjp, this.idjenisshare) {
    // telkomsel = 0;
    // isat = 0;
    // xl = 0;
    // tri = 0;
    // sf = 0;
    // axis = 0;
    // other = 0;
    isServerExist = false;
    pathPhoto1 = null;
    pathPhoto2 = null;
    pathPhoto3 = null;
  }

  EnumNumber? getPhotoKe() {
    if (pathPhoto1 == null) {
      return EnumNumber.satu;
    }

    if (pathPhoto2 == null) {
      return EnumNumber.dua;
    }

    if (pathPhoto3 == null) {
      return EnumNumber.tiga;
    }
    return null;
  }

  Merchandising.fromJson(Map<String, dynamic> map) {
    telkomsel = ConverterNumber.stringToInt(map['telkomsel']);
    isat = ConverterNumber.stringToInt(map['isat']);
    xl = ConverterNumber.stringToInt(map['xl']);
    tri = ConverterNumber.stringToInt(map['tri']);
    sf = ConverterNumber.stringToInt(map['smartfren']);
    axis = ConverterNumber.stringToInt(map['axis']);
    other = ConverterNumber.stringToInt(map['other']);
    idjenisshare = map['id_jenis_share'];
    pathPhoto1 = map['foto_1'];
    pathPhoto2 = map['foto_2'];
    pathPhoto3 = map['foto_3'];
  }

  Map<String, dynamic> toJson() {
    return {
      "id_tempat": '${pjp!.id}',
      "id_jenis_share": idjenisshare,
      "telkomsel": telkomsel,
      "isat": isat,
      "xl": xl,
      "tri": tri,
      "smartfren": sf,
      "axis": axis,
      "other": other
    };
  }
}
