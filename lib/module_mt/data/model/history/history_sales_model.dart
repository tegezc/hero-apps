import 'package:hero/module_mt/domain/entity/history/sales/history_sales.dart';

class HistorySalesModel extends HistorySales {
  HistorySalesModel(
      {required String idSales,
      required String namaSales,
      required String keterangan})
      : super(idSales: idSales, namaSales: namaSales, keterangan: keterangan);

  factory HistorySalesModel.fromJson(Map<String, dynamic> json) {
    return HistorySalesModel(
        idSales: json['id_sales'] ?? '',
        namaSales: json['nama_sales'] ?? '',
        keterangan: json['keterangan'] ?? '');
  }
}
