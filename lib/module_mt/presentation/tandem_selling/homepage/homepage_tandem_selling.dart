import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero/config/configuration_sf.dart';
import 'package:hero/core/log/printlog.dart';
import 'package:hero/module_mt/domain/entity/common/cluster.dart';
import 'package:hero/module_mt/domain/entity/common/sales.dart';
import 'package:hero/module_mt/domain/entity/common/tap.dart';
import 'package:hero/module_mt/domain/entity/common/outlet_mt.dart';
import 'package:hero/module_mt/presentation/common/homepage_search/cell_outlet.dart';
import 'package:hero/module_mt/presentation/common/widgets/Page_mt_error.dart';
import 'package:hero/module_mt/presentation/common/widgets/page_loading_mt.dart';
import 'package:hero/module_mt/presentation/tandem_selling/detail_outlet/detail_outlet.dart';
import 'package:hero/module_mt/presentation/tandem_selling/penilaian_sf/hp_peilaian_sf.dart';
import 'package:hero/util/component/button/component_button.dart';
import 'package:hero/util/component/label/component_label.dart';
import 'package:hero/util/component/widget/component_widget.dart';
import 'package:hero/util/component/widget/horeboxdecoration.dart';
import 'package:hero/util/component/widget/widgetpencariankosong.dart';
import 'package:hero/util/uiutil.dart';

import 'bloc/hp_tandem_selling_cubit.dart';

class HomePageTandemSelling extends StatefulWidget {
  const HomePageTandemSelling({Key? key}) : super(key: key);

  @override
  _HomePageTandemSellingState createState() => _HomePageTandemSellingState();
}

class _HomePageTandemSellingState extends State<HomePageTandemSelling> {
  final TextEditingController textEditingController = TextEditingController();

  final HoreBoxDecoration _boxDecoration = HoreBoxDecoration();
  final HpTandemSellingCubit _bloc = HpTandemSellingCubit();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String title = 'Tandem Selling';
    Size s = MediaQuery.of(context).size;
    double heightContentSearch = s.height - 280;
    return BlocProvider<HpTandemSellingCubit>(
      create: (context) => _bloc..setupData(),
      child: BlocBuilder<HpTandemSellingCubit, HpTandemSellingState>(
        builder: (context, state) {
          if (state is HpTandemSellingInitial) {
            return ScaffoldMT(body: Container(), title: 'Loading..');
          }

          if (state is HpTandemSellingError) {
            return const PageMtError(
              message: 'Terjadi Kesalahan',
            );
          }

          if (state is HpTandemSellingLoading) {
            return const LoadingNungguMT(
                'Mohon tunggu\nSedang menyiapkan data.');
          }

          if (state is HpTandemSellingLoaded) {
            HpTandemSellingLoaded item = state;
            return ScaffoldMT(
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: searchFilter(item),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: ButtonStrectWidth(
                            buttonColor: Colors.green,
                            text: 'Penilain SF',
                            onTap: () {
                              CommonUi().openPage(context,
                                  HpPenilaianSf(sales: item.currentSales!));
                            },
                            isenable: true),
                      ),
                      Container(
                          height: heightContentSearch,
                          margin: const EdgeInsets.all(8.0),
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              //color: Colors.red[600],
                              borderRadius: BorderRadius.circular(10.0),
                              gradient: getGradientBackground()),
                          child: controllContentPencarian(
                              heightContentSearch, item)),
                    ],
                  ),
                ),
                title: title);
          }
          return const PageMtError(message: 'Terjadi Kesalahan.');
        },
      ),
    );
  }

  Gradient getGradientBackground() {
    return _boxDecoration.gradientBackgroundApp();
  }

  Widget headerPencarian() {
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

  Widget controllContentPencarian(double height, HpTandemSellingLoaded item) {
    List<OutletMT>? lOutlet = item.lOutlet;
    if (lOutlet == null) {
      return const WidgetPencarianKosong(
          text:
              'Silahkan masukkan kriteria pencarian \nuntuk mendapatkan hasil pencarian');
    } else {
      if (lOutlet.isEmpty) {
        return const WidgetPencarianKosong(
            text: 'Pencarian dengan kriteria tersebut \nTIDAK DITEMUKAN.');
      } else {
        return Column(
          children: [
            headerPencarian(),
            SizedBox(height: height - 100, child: content(item)),
          ],
        );
      }
    }
  }

  Widget content(HpTandemSellingLoaded item) {
    List<OutletMT> items = item.lOutlet!;
    return ListView.builder(
      padding: const EdgeInsets.only(top: 20),
      // shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return CellOutlet(
            outletMT: items[index],
            onTap: () {
              CommonUi().openPage(
                  context,
                  DetailOutlet(
                    outletMT: items[index],
                    cluster: item.currentCluster!.namaCluster,
                    tap: item.currentTap!.namaTap,
                  ));
            });
      },
    );
  }

  Widget comboCluster(HpTandemSellingLoaded item) {
    Size s = MediaQuery.of(context).size;
    return Row(
      children: [
        const SizedBox(
          width: 70,
          child: LabelBlack.size1('Cluster'),
        ),
        const SizedBox(
          width: 15,
          child: LabelBlack.size1(':'),
        ),
        SizedBox(
          width: s.width - 130,
          child: Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: DropdownButton<Cluster>(
              items: item.lCluster
                  .map((o) => DropdownMenuItem<Cluster>(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            o.toString(),
                            style: const TextStyle(
                                color: Colors.black, fontSize: 14),
                          ),
                        ),
                        value: o,
                      ))
                  .toList(),
              onChanged: (value) {
                _bloc.changeCombobox(value);
              },
              value: item.currentCluster,
              isExpanded: false,
              hint: const LabelBlack.size2('Pilih'),
            ),
          ),
        ),
      ],
    );
  }

  Widget comboTap(HpTandemSellingLoaded item) {
    Size s = MediaQuery.of(context).size;
    return Row(
      children: [
        const SizedBox(
          width: 70,
          child: LabelBlack.size1('Tap'),
        ),
        const SizedBox(
          width: 15,
          child: LabelBlack.size1(':'),
        ),
        SizedBox(
          width: s.width - 130,
          child: Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: DropdownButton<Tap>(
              items: item.lTap
                  .map((o) => DropdownMenuItem<Tap>(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            o.toString(),
                            style: const TextStyle(
                                color: Colors.black, fontSize: 14),
                          ),
                        ),
                        value: o,
                      ))
                  .toList(),
              onChanged: (value) {
                _bloc.changeCombobox(value);
              },
              value: item.currentTap,
              isExpanded: false,
              hint: const LabelBlack.size2('Pilih'),
            ),
          ),
        ),
      ],
    );
  }

  Widget comboSales(HpTandemSellingLoaded item) {
    Size s = MediaQuery.of(context).size;
    return Row(
      children: [
        const SizedBox(
          width: 70,
          child: LabelBlack.size1('ID Sales'),
        ),
        const SizedBox(
          width: 15,
          child: LabelBlack.size1(':'),
        ),
        SizedBox(
          width: s.width - 190,
          child: Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: DropdownButton<Sales>(
              items: item.lSales
                  .map((o) => DropdownMenuItem<Sales>(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            o.toString(),
                            style: const TextStyle(
                                color: Colors.black, fontSize: 14),
                          ),
                        ),
                        value: o,
                      ))
                  .toList(),
              onChanged: (value) {
                _bloc.changeCombobox(value);
              },
              value: item.currentSales,
              isExpanded: false,
              hint: const LabelBlack.size2('Pilih'),
            ),
          ),
        ),
      ],
    );
  }

  Widget searchFilter(HpTandemSellingLoaded item) {
    //double w = MediaQuery.of(context).size.width;
    ph('curretnTap: ${item.currentTap}');
    return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: comboCluster(item),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: comboTap(item),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 4.0, bottom: 8, right: 4, top: 8),
              child: Row(
                children: [
                  const SizedBox(
                    width: 6,
                  ),
                  comboSales(item),
                  IconButton(
                      icon: const Icon(Icons.search, size: 30),
                      onPressed: () {
                        _bloc.searchOutletMt();
                      })
                ],
              ),
            ),
          ],
        ));
  }
}
