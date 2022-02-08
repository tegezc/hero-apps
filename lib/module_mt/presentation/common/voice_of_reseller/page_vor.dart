import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero/module_mt/domain/entity/common/outlet_mt.dart';
import 'package:hero/module_mt/domain/entity/common/voice_of_retailer/voice_of_reseller.dart';
import 'package:hero/module_mt/presentation/common/e_kegiatan_mt.dart';
import 'package:hero/module_mt/presentation/common/hive_mt.dart';

import 'package:hero/module_mt/presentation/common/voice_of_reseller/vos_record_video.dart';
import 'package:hero/module_mt/presentation/common/voice_of_reseller/vos_video_viewer_only.dart';
import 'package:hero/module_mt/presentation/common/widgets/widget_success.dart';

import '../../../../util/component/button/component_button.dart';
import '../../../../util/component/label/component_label.dart';
import '../../../../util/component/widget/component_widget.dart';
import '../../../../util/uiutil.dart';
import '../../../domain/entity/common/voice_of_retailer/jawaban.dart';
import '../../../domain/entity/common/voice_of_retailer/pertanyaan.dart';
import '../widgets/dialog/dialog_confirm.dart';
import '../widgets/dialog/dialog_error.dart';
import '../widgets/dialog/dialog_loading.dart';
import 'cobit_logic/logic_cubit.dart';

class PageVoiceOfReseller extends StatefulWidget {
  final VoiceOfReseller vor;
  final OutletMT outletMT;
  final EKegitatanMt eKegitatanMt;
  const PageVoiceOfReseller(
      {Key? key,
      required this.vor,
      required this.outletMT,
      required this.eKegitatanMt})
      : super(key: key);

  @override
  _PageVoiceOfResellerState createState() => _PageVoiceOfResellerState();
}

class _PageVoiceOfResellerState extends State<PageVoiceOfReseller> {
  late LogicCubit _logicCubit;
  @override
  void initState() {
    super.initState();
    _logicCubit = LogicCubit(
        vor: widget.vor,
        outletMT: widget.outletMT,
        eKegiatanMt: widget.eKegitatanMt);
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMT(
      body: SingleChildScrollView(
        child: BlocProvider(
          create: (context) => _logicCubit,
          child: BlocListener<LogicCubit, LogicState>(
            listener: (context, state) {
              if (state is LoadingSubmitData) {
                TgzDialogLoading()
                    .loadingDialog(context, text: 'Sedang Submit data');
              }
              if (state is ConfirmSubmit) {
                TgzDialogConfirm()
                    .confirmTwoButton(
                        context, "Apakah anda yakin akan submit data")
                    .then((value) {
                  if (value != null) {
                    _logicCubit.submit();
                  }
                });
              }

              if (state is AllCommboNotPickedYet) {
                TgzDialogError().warningOneButton(context,
                    'Semua pertanyaan harus di jawab dan harus menyediakan video.');
              }

              if (state is SubmitSuccessOrNot) {
                Navigator.pop(context);
                if (state.isSuccess) {
                  TgzDialogConfirm()
                      .confirmOneButton(context, state.message)
                      .then((value) {
                    _logicCubit.refresh();
                  });
                } else {
                  TgzDialogError().warningOneButton(context, state.message);
                }
              }
            },
            child: BlocBuilder<LogicCubit, LogicState>(
              builder: (context, state) {
                VoiceOfReseller vor = state.vor;
                late bool value;
                if (widget.eKegitatanMt == EKegitatanMt.backchecking) {
                  value =
                      HiveMT.backchecking(widget.outletMT.idOutlet).getVOR();
                } else {
                  value = HiveMT.tandem(
                          widget.outletMT.idOutlet, widget.outletMT.idSales)
                      .getVOR();
                }
                return value ? const WidgetSucces() : widgetPertanyaan(vor);
              },
            ),
          ),
        ),
      ),
      title: 'Voice Of Retailer',
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
              _logicCubit.setCurrentValueCombobox(index, value!);
            },
            value: pertanyaan.terpilih,
            isExpanded: false,
            hint: const LabelBlack.size2('Pilih'),
          ),
        ),
      ],
    );
  }

  Widget widgetPertanyaan(VoiceOfReseller vor) {
    //double w = MediaQuery.of(context).size.width;
    List<Widget> lw = [];
    for (var i = 0; i < vor.lPertanyaan.length; i++) {
      Pertanyaan p = vor.lPertanyaan[i];
      lw.add(combo(p, i));
      lw.add(const SizedBox(
        height: 16,
      ));
    }

    lw.add(Padding(
      padding: const EdgeInsets.all(8.0),
      child: vor.pathVideo == null
          ? ButtonStrectWidth(
              buttonColor: Colors.green,
              text: 'Ambil Video',
              onTap: () {
                CommonUi()
                    .openPage(context, const VOSRecordVideo())
                    .then((value) {
                  if (value != null) {
                    if (value is String) {
                      _logicCubit.setVideoPath(value);
                    }
                  }
                });
              },
              isenable: true)
          : FractionallySizedBox(
              widthFactor: 0.9,
              child: VOSVideoViewerOnly(pathVideo: vor.pathVideo)),
    ));

    lw.add(Padding(
      padding: const EdgeInsets.all(8.0),
      child: ButtonStrectWidth(
          buttonColor: Colors.red,
          text: 'Submit',
          onTap: () {
            _logicCubit.confirmSubmit();
          },
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
