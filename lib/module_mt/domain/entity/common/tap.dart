class Tap {
  String idTap;
  String namaTap;
  Tap({required this.idTap, required this.namaTap});

  bool isValid() {
    if (idTap.isNotEmpty && namaTap.isNotEmpty) {
      return true;
    }
    return false;
  }
}
