import 'package:flutter/material.dart';
import 'package:hero/module_mt/domain/entity/tandem_selling/pertanyaan_sf.dart';
import 'package:hero/module_mt/presentation/tandem_selling/penilaian_sf/enum_penilaian_sf.dart';

import '../../../../util/component/label/component_label.dart';
import '../../../domain/entity/tandem_selling/static_nilai_sf.dart';

class CardPertanyaanSF extends StatefulWidget {
  final List<PertanyaanSf> lPertanyaan;
  final EPenilaianSF ePenilaianSF;
  CardPertanyaanSF(
      {Key? key, required this.lPertanyaan, required this.ePenilaianSF})
      : super(key: key);

  @override
  State<CardPertanyaanSF> createState() => _CardPertanyaanSFState();
}

class _CardPertanyaanSFState extends State<CardPertanyaanSF> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Widget comboSales(PertanyaanSf pertanyaanSf) {
    List<StaticNilaiSf> ls = comboboxNilaiSF;
    Size s = MediaQuery.of(context).size;
    return Row(
      children: [
        SizedBox(
            width: s.width - 160,
            child: LabelBlack.size3(pertanyaanSf.pertanyaan)),
        Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: DropdownButton<StaticNilaiSf>(
            items: ls
                .map((o) => DropdownMenuItem<StaticNilaiSf>(
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
