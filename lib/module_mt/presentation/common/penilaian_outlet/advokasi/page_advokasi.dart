import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero/module_mt/domain/entity/common/outlet_mt.dart';
import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/advokasi.dart';
import 'package:hero/module_mt/presentation/common/e_kegiatan_mt.dart';
import 'package:hero/module_mt/presentation/common/hive_mt.dart';
import 'package:hero/util/component/button/component_button.dart';

import '../../widgets/widget_success.dart';
import '../enum_penilaian.dart';
import '../parent_tab/cubit/penilaianoutlet_cubit.dart';
import 'card_question_list.dart';

class PageAdvokasi extends StatefulWidget {
  const PageAdvokasi(
      {Key? key,
      required this.advokasi,
      required this.outletMT,
      required this.eKegitatanMt})
      : super(key: key);
  final Advokasi advokasi;
  final OutletMT outletMT;
  final EKegitatanMt eKegitatanMt;

  @override
  _PageAdvokasiState createState() => _PageAdvokasiState();
}

class _PageAdvokasiState extends State<PageAdvokasi> {
  @override
  Widget build(BuildContext context) {
    bool value;
    if (widget.eKegitatanMt == EKegitatanMt.backchecking) {
      value = HiveMT.backchecking(widget.outletMT.idOutlet).getAdvokat();
    } else {
      value = HiveMT.tandem(widget.outletMT.idOutlet, widget.outletMT.idSales)
          .getAdvokat();
    }
    return value
        ? const WidgetSucces()
        : SingleChildScrollView(
            child: Column(
              children: [
                CardQuestionList(questions: widget.advokasi.lquestions),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ButtonStrectWidth(
                      buttonColor: Colors.red,
                      text: 'Submit',
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        BlocProvider.of<PenilaianoutletCubit>(context)
                            .confirmSubmit(ETabPenilaian.advokasi);
                      },
                      isenable: true),
                ),
                const SizedBox(
                  height: 80,
                ),
              ],
            ),
          );
  }
}
