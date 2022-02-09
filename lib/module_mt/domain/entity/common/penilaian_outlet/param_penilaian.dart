class ParamPenilaian {
  final String idparam;
  final String param;
  final String judul;
  int? nilai;

  bool isValidToSubmit() {
    if (nilai == null) {
      return false;
    }
    return true;
  }

  ParamPenilaian(
      {required this.param,
      required this.idparam,
      this.nilai,
      required this.judul});
}
