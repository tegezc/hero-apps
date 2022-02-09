import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero/module_mt/presentation/common/widgets/dialog/dialog_loading.dart';
import 'package:hero/module_mt/presentation/history_outlet/AdapterHistory.dart';
import 'package:hero/module_mt/presentation/history_outlet/adapter_item_history.dart';
import 'package:hero/module_mt/presentation/history_outlet/cubit/history_cubit.dart';
import 'package:hero/module_mt/presentation/history_outlet/enum_history.dart';
import 'package:hero/util/component/button/component_button.dart';
import 'package:hero/util/component/label/component_label.dart';
import 'package:hero/util/component/widget/component_widget.dart';
import 'package:hero/util/component/widget/horeboxdecoration.dart';
import 'package:hero/util/component/widget/widgetpencariankosong.dart';
import 'package:hero/util/dateutil.dart';

class HistorySearchPage extends StatefulWidget {
  final EHistory eHistory;
  const HistorySearchPage(this.eHistory, {Key? key}) : super(key: key);
  @override
  _HistorySearchPageState createState() => _HistorySearchPageState();
}

class _HistorySearchPageState extends State<HistorySearchPage> {
  final TextEditingController _controller = TextEditingController();

  final HoreBoxDecoration _boxDecoration = HoreBoxDecoration();
  final HistoryCubit _cubit = HistoryCubit();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    String title = widget.eHistory == EHistory.sales ? 'Sales' : 'Outlet';
    return BlocProvider(
      create: (context) => HistoryCubit(),
      child: ScaffoldMT(
        title: title,
        body: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                //image: AssetImage('assets/image/coverage/BG.png'),
                image: AssetImage('assets/image/new/BG.png'),
                fit: BoxFit.cover,
              ),
            ),
            height: s.height,
            child: Container(
              padding: const EdgeInsets.only(left: 8, right: 8, top: 10),
              height: s.height,
              width: s.width,
              child: BlocListener<HistoryCubit, HistoryState>(
                bloc: _cubit,
                listener: (context, state) {
                  if (state is HistoryLoading) {
                    TgzDialogLoading().loadingDialog(context);
                  }

                  if (state is SuccessSearchFinish) {
                    Navigator.pop(context);
                  }
                },
                child: BlocBuilder<HistoryCubit, HistoryState>(
                  bloc: _cubit..setupData(),
                  builder: (context, state) {
                    // AdapterHistory item = AdapterHistory(
                    //     lItem: [], isButtonMoreShowing: false, awal: null, akhir: null);
                    AdapterHistory item = state.adapterHistory;
                    String strAwal = item.awal == null
                        ? 'Awal'
                        : DateUtility.dateToStringPanjang(item.awal);
                    String strAkhir = item.akhir == null
                        ? 'Akhir'
                        : DateUtility.dateToStringPanjang(item.akhir);
                    return Column(
                      children: [
                        //  LabelBlack.size1(title, bold: true),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 10.0,
                            right: 4.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ButtonApp.blue(strAwal, () {
                                _datePicker(true, item.awal, item.akhir);
                              }),
                              ButtonApp.blue(strAkhir, () {
                                _datePicker(false, item.awal, item.akhir);
                              }),
                              IconButton(
                                  icon: const Icon(
                                    Icons.search,
                                    //   size: 40,
                                  ),
                                  onPressed: () {
                                    _cubit.search(widget.eHistory);
                                  }),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: s.height - 160,
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  gradient:
                                      _boxDecoration.gradientBackgroundApp()),
                              margin: const EdgeInsets.only(
                                  top: 10.0, left: 0, right: 0),
                              padding: const EdgeInsets.all(5.0),
                              child: Card(
                                elevation: 0,
                                color: Colors.transparent,
                                child: Column(
                                  children: [
                                    _headerPencarian(),
                                    _controllContentPencarian(item.lItem),
                                    // _content(item),
                                  ],
                                ),
                              )),
                        ),
                        const SizedBox(
                          height: 70,
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _headerPencarian() {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          LabelWhite.size1("Berikut Daftar Pencarian : "),
          Divider(
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _controllContentPencarian(List<AdapterHistoryItem>? lItem) {
    Size s = MediaQuery.of(context).size;
    if (lItem == null) {
      return const WidgetPencarianKosong(
          text:
              'Silahkan pilih tanggal awal dan akhir \nuntuk mendapatkan hasil pencarian');
    }
    if (lItem.isEmpty) {
      return const WidgetPencarianKosong(
          text:
              'Pencarian data pada range tanggal tersebut \nTIDAK DITEMUKAN.');
    } else {
      return SizedBox(height: s.height - 225, child: _content(lItem));
    }
  }

  Widget _content(List<AdapterHistoryItem> lItem) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 20),
      shrinkWrap: true,
      //physics: NeverScrollableScrollPhysics(),
      itemCount: lItem.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: _cellController(lItem, index, false),
        );
      },
    );
  }

  Widget _btnShowMore() {
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

    return ElevatedButton(
      style: style,
      onPressed: () {},
      child: const Text('show more'),
    );
  }

  Widget _spasi() {
    return const SizedBox(
      height: 4,
    );
  }

  Widget _cellController(
      List<AdapterHistoryItem> lItem, int index, bool isPageComplete) {
    int tmp = lItem.length - 1;
    if (tmp == index) {
      if (isPageComplete) {
        return _btnShowMore();
      }
    }
    AdapterHistoryItem item = lItem[index];
    return _cellOutlet(item);
  }

  Widget _cellOutlet(AdapterHistoryItem item) {
    return GestureDetector(
      onTap: () {
        //_controllerTap(item);
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 8.0, right: 8.0, top: 1.0, bottom: 1.0),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.playlist_add_check,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LabelWhite.size3(item.id),
                          _spasi(),
                          LabelWhite.size3(item.nama),
                          _spasi(),
                          LabelWhite.size3(item.keterangan),
                          const Divider(),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _datePicker(bool isawal, DateTime? awal, DateTime? akhir) async {
    DateTime? dtawal = DateTime(DateTime.now().year - 5);
    DateTime dtakhir = DateTime(DateTime.now().year + 5);
    DateTime initialDt = DateTime.now();
    if (isawal == false) {
      if (awal != null) {
        dtawal = awal;
        initialDt = dtawal.add(const Duration(days: 1));
      }
    }
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDt,
      firstDate: dtawal,
      lastDate: dtakhir,
    );

    if (picked != null) {
      if (isawal) {
        _cubit.changeTglAwal(picked);
      } else {
        _cubit.chageTglAkhir(picked);
      }
    }
  }
}
