class HistoryOutlet {
  final String idDigipos;
  final String namaOutlet;
  final String keterangan;

  HistoryOutlet(
      {required this.idDigipos,
      required this.namaOutlet,
      required this.keterangan});

  bool isValid() {
    if (idDigipos.isEmpty || namaOutlet.isEmpty) {
      return false;
    }
    return true;
  }
}
