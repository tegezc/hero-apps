class Sales {
  final String idSales;
  final String namaSales;
  Sales({required this.idSales, required this.namaSales});

  bool isValid() {
    if (idSales.isNotEmpty && namaSales.isNotEmpty) {
      return true;
    }
    return false;
  }
}
