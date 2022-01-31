import 'package:hero/module_mt/domain/entity/common/sales.dart';

class SalesModel extends Sales {
  SalesModel({required String idSales, required String namaSales})
      : super(idSales: idSales, namaSales: namaSales);

  factory SalesModel.fromJson(Map<String, dynamic> json) {
    return SalesModel(
        idSales: json['id_sales'] ?? '', namaSales: json['nama_sales'] ?? '');
  }
}
