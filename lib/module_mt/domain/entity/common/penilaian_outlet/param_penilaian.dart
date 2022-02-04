class ParamPenilaian {
  final String idparam;
  final String param;
  int? nilai;

  bool isValidToSubmit() {
    if (nilai == null) {
      return false;
    }
    return true;
  }

  ParamPenilaian({required this.param, required this.idparam, this.nilai});
}
