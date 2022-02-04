import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero/module_mt/domain/entity/common/sales.dart';
import 'package:hero/module_mt/domain/entity/tandem_selling/penilaian_sf.dart';
import 'package:hero/module_mt/domain/entity/tandem_selling/pertanyaan_sf.dart';
import 'package:hero/module_mt/presentation/common/widgets/page_err_loading/page_mt_error.dart';
import 'package:hero/module_mt/presentation/common/widgets/page_err_loading/page_loading_mt.dart';
import 'package:hero/util/component/button/component_button.dart';
import 'package:hero/util/component/label/component_label.dart';
import 'package:hero/util/component/widget/component_widget.dart';

import 'cubit/penilainsf_cubit.dart';

class HpPenilaianSf extends StatefulWidget {
  const HpPenilaianSf({Key? key, required this.sales}) : super(key: key);
  final Sales sales;

  @override
  _HpPenilaianSfState createState() => _HpPenilaianSfState();
}

class _HpPenilaianSfState extends State<HpPenilaianSf> {
  // PenilaianSf penilaianSf = PenilaianSf(personalities: [
  //   PertanyaanSf(idPertanyaan: '1', pertanyaan: 'Pertanyaan personalities')
  // ], distribution: [
  //   PertanyaanSf(idPertanyaan: '2', pertanyaan: 'Pertanyaan distribution')
  // ], merchandising: [
  //   PertanyaanSf(idPertanyaan: '3', pertanyaan: 'Pertanyaan merchandising')
  // ], promotion: [
  //   PertanyaanSf(idPertanyaan: '7', pertanyaan: 'Pertanyaan promotion')
  // ]);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PenilainsfCubit()..setupData(widget.sales.idSales),
      child: BlocBuilder<PenilainsfCubit, PenilainsfState>(
        builder: (context, state) {
          if (state is PenilainsfInitial) {
            return ScaffoldMT(body: Container(), title: 'Loading..');
          }
          if (state is PenilainsfError) {
            return PageMtError(message: state.message);
          }
          if (state is PenilainsfLoading) {
            return const LoadingNungguMT(
                'Sedang mengambil data.\nMohon menunggu.');
          }

          if (state is PenilainsfLoaded) {
            PenilainsfLoaded item = state;
            PenilaianSf penilaianSf = item.penilaianSf;
            return ScaffoldMT(
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    cardPertanyaan(penilaianSf.personalities, 'Personalities'),
                    cardPertanyaan(penilaianSf.distribution, 'Distribution'),
                    cardPertanyaan(penilaianSf.merchandising, 'Merchandising'),
                    cardPertanyaan(penilaianSf.promotion, 'Promotion'),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          ButtonApp.green('Cek Nilai', () {}),
                          const Spacer(),
                          const LabelBlack.title('cek nilai'),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ButtonStrectWidth(
                          buttonColor: Colors.red,
                          text: 'Submit',
                          onTap: () {},
                          isenable: true),
                    ),
                    const SizedBox(
                      height: 80.0,
                    ),
                  ],
                ),
              ),
              title: 'Voice Of Retailer',
            );
          }

          return ScaffoldMT(body: Container(), title: 'Loading..');
        },
      ),
    );
  }

  Widget comboSales(PertanyaanSf pertanyaanSf) {
    List<String> ls = [
      'Terbaaeek',
      'Baik Sekali',
      'Baik',
      'Kurang',
      'Kurang Sekali'
    ];
    Size s = MediaQuery.of(context).size;
    return Row(
      children: [
        SizedBox(
            width: s.width - 160,
            child: LabelBlack.size3(pertanyaanSf.pertanyaan)),
        Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: DropdownButton<String>(
            items: ls
                .map((o) => DropdownMenuItem<String>(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 80,
                          child: Text(
                            o.toString(),
                            style: const TextStyle(
                                color: Colors.black, fontSize: 11),
                          ),
                        ),
                      ),
                      value: o,
                    ))
                .toList(),
            onChanged: (value) {},
            value: pertanyaanSf.nilai,
            isExpanded: false,
            hint: const LabelBlack.size3('Pilih'),
          ),
        ),
      ],
    );
  }

  Widget cardPertanyaan(List<PertanyaanSf> lPertanyaan, String title) {
    //double w = MediaQuery.of(context).size.width;
    List<Widget> lw = [];
    lw.add(LabelBlack.size1(title));
    lw.add(const Divider());
    for (var i = 0; i < lPertanyaan.length; i++) {
      PertanyaanSf p = lPertanyaan[i];

      lw.add(comboSales(p));
      lw.add(const SizedBox(
        height: 16,
      ));
    }
    return Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: lw,
          ),
        ));
  }
}
