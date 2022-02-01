import 'package:equatable/equatable.dart';

class Sales extends Equatable {
  final String idSales;
  final String namaSales;
  const Sales({required this.idSales, required this.namaSales});

  bool isValid() {
    if (idSales.isNotEmpty && namaSales.isNotEmpty) {
      return true;
    }
    return false;
  }

  @override
  String toString() {
    return idSales;
  }

  @override
  List<Object?> get props => [idSales];
}
