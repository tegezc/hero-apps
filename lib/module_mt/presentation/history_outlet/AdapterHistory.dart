import 'package:hero/module_mt/presentation/history_outlet/adapter_item_history.dart';

class AdapterHistory {
  List<AdapterHistoryItem>? lItem;
  bool isButtonMoreShowing;
  DateTime? awal;
  DateTime? akhir;
  AdapterHistory({
    required this.lItem,
    required this.isButtonMoreShowing,
    required this.awal,
    required this.akhir,
  });
}
