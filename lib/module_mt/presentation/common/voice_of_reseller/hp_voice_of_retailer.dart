import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero/module_mt/domain/entity/common/outlet_mt.dart';
import 'package:hero/module_mt/domain/entity/common/voice_of_retailer/jawaban.dart';
import 'package:hero/module_mt/domain/entity/common/voice_of_retailer/pertanyaan.dart';
import 'package:hero/module_mt/domain/entity/common/voice_of_retailer/voice_of_reseller.dart';
import 'package:hero/module_mt/presentation/common/widgets/Page_mt_error.dart';
import 'package:hero/module_mt/presentation/common/widgets/page_loading_mt.dart';
import 'package:hero/util/component/button/component_button.dart';
import 'package:hero/util/component/label/component_label.dart';
import 'package:hero/util/component/widget/component_widget.dart';

import 'cubit/voiceofreseller_cubit.dart';

class HPVoiceOfRetailer extends StatefulWidget {
  final OutletMT outletMT;
  const HPVoiceOfRetailer({Key? key, required this.outletMT}) : super(key: key);

  @override
  _HPVoiceOfRetailerState createState() => _HPVoiceOfRetailerState();
}

class _HPVoiceOfRetailerState extends State<HPVoiceOfRetailer> {
  final VoiceofresellerCubit _cubit = VoiceofresellerCubit();
  late List<Pertanyaan> lPertanyaan;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit..setupData(widget.outletMT.idOutlet),
      child: BlocBuilder<VoiceofresellerCubit, VoiceofresellerState>(
        builder: (context, state) {
          if (state is VoiceofresellerError) {
            return PageMtError(
              message: state.message,
            );
          }

          if (state is VoiceofresellerLoading ||
              state is VoiceofresellerInitial) {
            return const LoadingNungguMT(
                'Sedang mendapatkan data.\nMohon menunggu...');
          }

          if (state is VoiceofresellerLoaded) {
            VoiceofresellerLoaded? item = state;
            lPertanyaan = item.voiceOfReseller!.lPertanyaan;
            return ScaffoldMT(
              body: SingleChildScrollView(
                child: searchFilter(),
              ),
              title: 'Voice Of Retailer',
            );
          }

          return const PageMtError(message: 'Terjadi kesalahan');
        },
      ),
    );
  }

  Widget combo(Pertanyaan pertanyaan, int index) {
    Size s = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelBlack.size1('${index + 1}. ${pertanyaan.pertanyaan}'),
        const SizedBox(
          height: 8,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: DropdownButton<Jawaban>(
            items: pertanyaan.lJawaban
                .map((o) => DropdownMenuItem<Jawaban>(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: s.width - 100,
                          child: Text(
                            o.toString(),
                            style: const TextStyle(
                                color: Colors.black, fontSize: 14),
                          ),
                        ),
                      ),
                      value: o,
                    ))
                .toList(),
            onChanged: (value) {
              _cubit.setCurrentValueCombobox(index, value!);
              setState(() {
                lPertanyaan[index].terpilih = value;
              });
            },
            value: pertanyaan.terpilih,
            isExpanded: false,
            hint: const LabelBlack.size2('Pilih'),
          ),
        ),
      ],
    );
  }

  Widget searchFilter() {
    //double w = MediaQuery.of(context).size.width;
    List<Widget> lw = [];
    for (var i = 0; i < lPertanyaan.length; i++) {
      Pertanyaan p = lPertanyaan[i];
      lw.add(combo(p, i));
      lw.add(const SizedBox(
        height: 16,
      ));
    }
    lw.add(Padding(
      padding: const EdgeInsets.all(8.0),
      child: ButtonStrectWidth(
          buttonColor: Colors.red,
          text: 'Submit',
          onTap: () {},
          isenable: true),
    ));
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
