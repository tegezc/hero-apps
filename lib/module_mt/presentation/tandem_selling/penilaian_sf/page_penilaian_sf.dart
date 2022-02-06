import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero/module_mt/presentation/tandem_selling/penilaian_sf/enum_penilaian_sf.dart';
import 'package:hero/module_mt/presentation/tandem_selling/penilaian_sf/widget_card_pertanyaan_sf.dart';

import '../../../../util/component/button/component_button.dart';
import '../../../../util/component/label/component_label.dart';
import '../../../../util/component/widget/component_widget.dart';
import '../../../domain/entity/tandem_selling/penilaian_sf.dart';
import 'cubit_logic/penilainsf_cubit.dart';

class PagePenilaianSf extends StatefulWidget {
  final PenilaianSf penilaianSf;
  const PagePenilaianSf({Key? key, required this.penilaianSf})
      : super(key: key);

  @override
  _PagePenilaianSfState createState() => _PagePenilaianSfState();
}

class _PagePenilaianSfState extends State<PagePenilaianSf> {
  late PenilainsfCubit _logicCubit;
  @override
  void initState() {
    super.initState();
    _logicCubit = PenilainsfCubit(cachePenilaianSf: widget.penilaianSf);
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMT(
      body: BlocProvider(
        create: (context) => _logicCubit,
        child: SingleChildScrollView(
          child: BlocListener<PenilainsfCubit, PenilainsfState>(
            listener: (context, state) {},
            child: BlocBuilder<PenilainsfCubit, PenilainsfState>(
              builder: (context, state) {
                PenilaianSf penilaianSf = state.penilaianSf;
                return Column(
                  children: [
                    CardPertanyaanSF(
                        ePenilaianSF: EPenilaianSF.personalities,
                        lPertanyaan: penilaianSf.personalities),
                    CardPertanyaanSF(
                        ePenilaianSF: EPenilaianSF.distribution,
                        lPertanyaan: penilaianSf.distribution),
                    CardPertanyaanSF(
                        ePenilaianSF: EPenilaianSF.merchandising,
                        lPertanyaan: penilaianSf.merchandising),
                    CardPertanyaanSF(
                        ePenilaianSF: EPenilaianSF.promotion,
                        lPertanyaan: penilaianSf.promotion),
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
                );
              },
            ),
          ),
        ),
      ),
      title: 'Voice Of Retailer',
    );
  }
}
