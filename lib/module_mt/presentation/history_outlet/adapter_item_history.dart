import 'package:hero/module_mt/domain/entity/history/outlet/history_outlet.dart';
import 'package:hero/module_mt/domain/entity/history/sales/history_sales.dart';

class AdapterHistoryItem {
  final String id;
  final String nama;
  final String keterangan;

  AdapterHistoryItem(
      {required this.id, required this.nama, required this.keterangan});

  factory AdapterHistoryItem.fromSales(HistorySales hs) {
    return AdapterHistoryItem(
        id: hs.idSales, nama: hs.namaSales, keterangan: hs.keterangan);
  }
  factory AdapterHistoryItem.fromOutlet(HistoryOutlet ho) {
    return AdapterHistoryItem(
        id: ho.idDigipos, nama: ho.namaOutlet, keterangan: ho.keterangan);
  }
}
//============
// Outlet
// {
// "id_digipos": "1300000001",
// "nama_outlet": "OUTLET A",
// "lastmodified": "2022-02-07 14:11:33",
// "keterangan": "penilaian outlet"
// },

//============
// Sales
// {
// "id_sales": "SSF0018",
// "nama_sales": "Afiqa Shofia Putri",
// "lastmodified": "2022-02-07 14:17:17",
// "keterangan": "penilaian sf"
// },
