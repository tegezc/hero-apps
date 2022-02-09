import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero/module_mt/domain/entity/common/outlet_mt.dart';
import 'package:hero/module_mt/presentation/back_checking/widget_textfield_withlabel.dart';
import 'package:hero/module_mt/presentation/common/e_kegiatan_mt.dart';
import 'package:hero/module_mt/presentation/common/homepage_search/cell_outlet.dart';
import 'package:hero/module_mt/presentation/common/widgets/page_err_loading/page_mt_error.dart';
import 'package:hero/module_mt/presentation/common/widgets/page_err_loading/page_loading_mt.dart';
import 'package:hero/util/component/label/component_label.dart';
import 'package:hero/util/component/widget/component_widget.dart';
import 'package:hero/util/component/widget/horeboxdecoration.dart';
import 'package:hero/util/component/widget/widgetpencariankosong.dart';
import 'package:hero/util/uiutil.dart';

import '../common/detail_outlet/detail_outlet.dart';
import 'cubit/home_back_checking_cubit.dart';

class HPBackChecking extends StatefulWidget {
  const HPBackChecking({Key? key}) : super(key: key);

  @override
  _HPBackCheckingState createState() => _HPBackCheckingState();
}

class _HPBackCheckingState extends State<HPBackChecking> {
  final TextEditingController textEditingController = TextEditingController();

  final HoreBoxDecoration _boxDecoration = HoreBoxDecoration();
  final HomeBackCheckingCubit _bloc = HomeBackCheckingCubit();
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
    String title = 'Back Checking';
    Size s = MediaQuery.of(context).size;
    double heightContentSearch = s.height - 175;
    return BlocProvider<HomeBackCheckingCubit>(
      create: (context) => _bloc..setupData(),
      child: BlocBuilder<HomeBackCheckingCubit, HomeBackCheckingState>(
        builder: (context, state) {
          if (state is HomeBackCheckingInitial) {
            return ScaffoldMT(body: Container(), title: 'Loading..');
          }

          if (state is HomeBackCheckingError) {
            return const PageMtError(
              message: 'Terjadi Kesalahan',
            );
          }

          if (state is HomeBackCheckingLoading) {
            return const LoadingNungguMT(
                'Mohon tunggu\nSedang menyiapkan data.');
          }

          if (state is HomeBackCheckingLoaded) {
            return ScaffoldMT(
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: searchFilter(state),
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
                              heightContentSearch, state)),
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

  Widget controllContentPencarian(double height, HomeBackCheckingLoaded item) {
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
            SizedBox(height: height - 70, child: content(item)),
          ],
        );
      }
    }
  }

  Widget content(HomeBackCheckingLoaded item) {
    List<OutletMT> items = item.lOutlet!;
    return ListView.builder(
      padding: const EdgeInsets.only(top: 0),
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
                    cluster: null,
                    tap: null,
                    eKegitatanMt: EKegitatanMt.backchecking,
                  ));
            });
      },
    );
  }

  Widget searchFilter(HomeBackCheckingLoaded item) {
    Size s = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 4.0, bottom: 8, right: 4, top: 8),
          child: Row(
            children: [
              TextFieldWithlabel(
                controller: textEditingController,
                widthTextField: s.width - 80,
                onChanged: (value) {},
                enable: true,
              ),
              IconButton(
                  icon: const Icon(Icons.search, size: 30),
                  onPressed: () {
//                    _bloc.searchOutletMt(textEditingController.text);
                    _bloc.searchOutletMt('OUTLET');
                  })
            ],
          ),
        ),
      ],
    );
  }
}
