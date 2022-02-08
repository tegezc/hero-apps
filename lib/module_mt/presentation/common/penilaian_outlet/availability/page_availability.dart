import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero/module_mt/domain/entity/common/outlet_mt.dart';
import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/availability.dart';
import 'package:hero/module_mt/presentation/common/e_kegiatan_mt.dart';
import 'package:hero/module_mt/presentation/common/hive_mt.dart';
import 'package:hero/module_mt/presentation/common/penilaian_outlet/parent_tab/cubit/penilaianoutlet_cubit.dart';
import 'package:hero/module_mt/presentation/common/widgets/widget_success.dart';
import 'package:hero/util/component/button/component_button.dart';

import '../enum_penilaian.dart';
import 'card_question.dart';
import 'card_table.dart';

class PageAvailability extends StatefulWidget {
  const PageAvailability(
      {Key? key, required this.availability, required this.outletMT,required this.eKegitatanMt})
      : super(key: key);
  final Availability availability;
  final OutletMT outletMT;
  final EKegitatanMt eKegitatanMt;

  @override
  _PageAvailabilityState createState() => _PageAvailabilityState();
}

class _PageAvailabilityState extends State<PageAvailability> {
  @override
  Widget build(BuildContext context) {
    bool value ;
    if(widget.eKegitatanMt == EKegitatanMt.backchecking){
      value = HiveMT.backchecking(widget.outletMT.idOutlet).getAvailability();
    }else{
      value = HiveMT.tandem(widget.outletMT.idOutlet,widget.outletMT.idSales).getAvailability();
    }
    return value
        ? const WidgetSucces()
        : SingleChildScrollView(
            child: Column(
              children: [
                CardTableParameter(
                  kategories: widget.availability.kategoriOperator,
                  eJenisParam: EJenisParam.perdana,
                  ePhoto: EPhotoPenilaian.avPerdana,
                  textButton: 'Foto Perdana',
                  pathImage: widget.availability.pathPhotoOperator,
                ),
                const SizedBox(
                  height: 8,
                ),
                CardTableParameter(
                  kategories: widget.availability.kategoriVF,
                  eJenisParam: EJenisParam.vk,
                  ePhoto: EPhotoPenilaian.avVf,
                  textButton: 'Foto Voucher Fisik',
                  pathImage: widget.availability.pathPhotoVF,
                ),
                const SizedBox(
                  height: 8,
                ),
                CardQuestion(questions: widget.availability.question),
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
                            .confirmSubmit(ETabPenilaian.availability);
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
