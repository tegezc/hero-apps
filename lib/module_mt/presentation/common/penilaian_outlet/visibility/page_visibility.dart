import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero/module_mt/domain/entity/common/outlet_mt.dart';
import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/visibility.dart';
import 'package:hero/module_mt/presentation/common/e_kegiatan_mt.dart';
import 'package:hero/module_mt/presentation/common/penilaian_outlet/availability/card_table.dart';
import 'package:hero/module_mt/presentation/common/widgets/image_file.dart';
import 'package:hero/util/component/button/component_button.dart';
import 'package:hero/util/uiutil.dart';

import '../../hive_mt.dart';
import '../../widgets/widget_success.dart';
import '../enum_penilaian.dart';
import '../parent_tab/cubit/penilaianoutlet_cubit.dart';
import '../penilaian_take_photo.dart';
import 'card_question_single.dart';

class PageVisibility extends StatefulWidget {
  const PageVisibility(
      {Key? key,
      required this.penilaianVisibility,
      required this.outletMT,
      required this.eKegitatanMt})
      : super(key: key);
  final PenilaianVisibility penilaianVisibility;
  final OutletMT outletMT;
  final EKegitatanMt eKegitatanMt;

  @override
  _PageVisibilityState createState() => _PageVisibilityState();
}

class _PageVisibilityState extends State<PageVisibility> {
  @override
  Widget build(BuildContext context) {
    late bool value;
    if (widget.eKegitatanMt == EKegitatanMt.backchecking) {
      value = HiveMT.backchecking(widget.outletMT.idOutlet).getVisibility();
    } else {
      value = HiveMT.tandem(widget.outletMT.idOutlet, widget.outletMT.idSales)
          .getVisibility();
    }
    return value
        ? const WidgetSucces()
        : SingleChildScrollView(
            child: Column(
              children: [
                CardQuestionSingle(
                  question: widget.penilaianVisibility.questionAtas,
                  isBawah: false,
                ),
                const SizedBox(
                  height: 8,
                ),
                widget.penilaianVisibility.imageEtalase == null
                    ? ButtonStrectWidth(
                        buttonColor: Colors.green,
                        text: 'Foto semua Etalase',
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          CommonUi()
                              .openPage(context, const PenilaianTakePhoto())
                              .then((value) {
                            if (value != null) {
                              if (value is String) {
                                BlocProvider.of<PenilaianoutletCubit>(context)
                                    .setPathImage(
                                        value, EPhotoPenilaian.etalase);
                              }
                            }
                          });
                        },
                        isenable: true)
                    : ImageFile(
                        pathPhoto: widget.penilaianVisibility.imageEtalase),
                const SizedBox(
                  height: 8,
                ),
                CardTableParameter(
                  kategories: widget.penilaianVisibility.kategoriesPoster,
                  eJenisParam: EJenisParam.poster,
                  ePhoto: EPhotoPenilaian.poster,
                  textButton: 'Foto Poster',
                  pathImage: widget.penilaianVisibility.imagePoster,
                ),
                const SizedBox(
                  height: 8,
                ),
                CardTableParameter(
                  kategories: widget.penilaianVisibility.kategoriesLayar,
                  eJenisParam: EJenisParam.layar,
                  ePhoto: EPhotoPenilaian.layar,
                  textButton: 'Foto Layar',
                  pathImage: widget.penilaianVisibility.imageLayar,
                ),
                const SizedBox(
                  height: 8,
                ),
                CardQuestionSingle(
                  question: widget.penilaianVisibility.questionBawah,
                  isBawah: true,
                ),
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
                            .confirmSubmit(ETabPenilaian.visibility);
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
