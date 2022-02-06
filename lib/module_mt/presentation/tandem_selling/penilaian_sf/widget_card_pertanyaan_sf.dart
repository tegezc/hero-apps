import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero/module_mt/domain/entity/tandem_selling/penilaian_sf.dart';
import 'package:hero/module_mt/domain/entity/tandem_selling/pertanyaan_sf.dart';
import 'package:hero/module_mt/presentation/tandem_selling/penilaian_sf/enum_penilaian_sf.dart';

import '../../../../util/component/label/component_label.dart';
import '../../../domain/entity/tandem_selling/static_nilai_sf.dart';
import 'cubit_logic/penilainsf_cubit.dart';

class CardPertanyaanSF extends StatefulWidget {
  final PenilaianSf penilaianSf;
  final EPenilaianSF ePenilaianSF;
  const CardPertanyaanSF(
      {Key? key, required this.penilaianSf, required this.ePenilaianSF})
      : super(key: key);

  @override
  State<CardPertanyaanSF> createState() => _CardPertanyaanSFState();
}

class _CardPertanyaanSFState extends State<CardPertanyaanSF> {
  @override
  Widget build(BuildContext context) {
    return cardPertanyaan(widget.penilaianSf, widget.ePenilaianSF);
  }

  Widget comboSales(PertanyaanSf pertanyaanSf, List<NilaiSf> lNilai,
      EPenilaianSF ePen, int index) {
    Size s = MediaQuery.of(context).size;
    return Row(
      children: [
        SizedBox(
            width: s.width - 160,
            child: LabelBlack.size3(pertanyaanSf.pertanyaan)),
        Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: DropdownButton<NilaiSf>(
            items: lNilai
                .map((o) => DropdownMenuItem<NilaiSf>(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 80,
                          child: Text(
                            o.desc,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 11),
                          ),
                        ),
                      ),
                      value: o,
                    ))
                .toList(),
            onChanged: (value) {
              BlocProvider.of<PenilainsfCubit>(context)
                  .changeCombobox(ePen, index, value!);
            },
            value: pertanyaanSf.nilai,
            isExpanded: false,
            hint: const LabelBlack.size3('Pilih'),
          ),
        ),
      ],
    );
  }

  Widget cardPertanyaan(PenilaianSf penilaianSf, EPenilaianSF ePen) {
    //double w = MediaQuery.of(context).size.width;
    String title = '';
    List<PertanyaanSf> lPertanyaanSF = [];
    switch (ePen) {
      case EPenilaianSF.personalities:
        title = 'Personalities';
        lPertanyaanSF = penilaianSf.personalities;
        break;
      case EPenilaianSF.distribution:
        title = 'Distribution';
        lPertanyaanSF = penilaianSf.distribution;
        break;
      case EPenilaianSF.merchandising:
        title = 'Merchandising';
        lPertanyaanSF = penilaianSf.merchandising;
        break;
      case EPenilaianSF.promotion:
        title = 'Promotion';
        lPertanyaanSF = penilaianSf.promotion;
        break;
    }
    List<Widget> lw = [];
    lw.add(LabelBlack.size1(title));
    lw.add(const Divider());
    for (var i = 0; i < lPertanyaanSF.length; i++) {
      PertanyaanSf p = lPertanyaanSF[i];

      lw.add(comboSales(p, penilaianSf.listPilihan, ePen, i));
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
