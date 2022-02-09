class HistorySales {
  final String idSales;
  final String namaSales;
  final String keterangan;
  HistorySales(
      {required this.idSales,
      required this.namaSales,
      required this.keterangan});

  bool isValid() {
    if (idSales.isEmpty || namaSales.isEmpty) {
      return false;
    }

    return true;
  }
}
