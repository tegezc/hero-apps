import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero/core/log/printlog.dart';
import 'package:hero/module_mt/presentation/common/widgets/dialog/dialog_confirm.dart';
import 'package:hero/module_mt/presentation/common/widgets/dialog/dialog_error.dart';
import 'package:hero/module_mt/presentation/common/widgets/dialog/dialog_loading.dart';
import 'package:hero/module_mt/presentation/tandem_selling/penilaian_sf/enum_penilaian_sf.dart';
import 'package:hero/module_mt/presentation/tandem_selling/penilaian_sf/widget_card_pertanyaan_sf.dart';

import '../../../../util/component/button/component_button.dart';
import '../../../../util/component/label/component_label.dart';
import '../../../../util/component/widget/component_widget.dart';
import '../../../domain/entity/tandem_selling/penilaian_sf.dart';
import '../../common/widgets/text_area.dart';
import '../../common/widgets/widget_success.dart';
import 'cubit_listener/clpenilaian_sf_cubit.dart';
import 'cubit_logic/penilainsf_cubit.dart';

class PagePenilaianSf extends StatefulWidget {
  final PenilaianSf penilaianSf;
  final String idSF;
  const PagePenilaianSf(
      {Key? key, required this.penilaianSf, required this.idSF})
      : super(key: key);

  @override
  _PagePenilaianSfState createState() => _PagePenilaianSfState();
}

class _PagePenilaianSfState extends State<PagePenilaianSf> {
  late PenilainsfCubit _logicCubit;
  late ClpenilaianSfCubit _cListener;

  final TextEditingController _messageController = TextEditingController();
  int _counter = 0;
  @override
  void initState() {
    super.initState();
    _cListener = ClpenilaianSfCubit();
    _logicCubit = PenilainsfCubit(
        cachePenilaianSf: widget.penilaianSf, idSales: widget.idSF);
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _setValueMessage() {
    if (_counter == 0) {
      _counter++;
      _messageController.text = widget.penilaianSf.message ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    _setValueMessage();
    return ScaffoldMT(
      body: BlocProvider(
        create: (context) => _logicCubit..setupData(),
        child: SingleChildScrollView(
          child: BlocListener<ClpenilaianSfCubit, ClpenilaianSfState>(
            bloc: _cListener,
            listener: (context, state) {
              if (state is SubmitConfirmed) {
                TgzDialogConfirm()
                    .confirmTwoButton(
                        context, "Apakah anda yakin akan submit data")
                    .then((value) {
                  if (value != null) {
                    _cListener.submit();
                  }
                });
              }

              if (state is FieldNotCompletedYet) {
                TgzDialogError().warningOneButton(context, state.message);
              }

              if (state is CheckNilaiSuccessOrNot) {
                Navigator.pop(context);
                _logicCubit.refreshCheckNilai(state.nilai);
              }

              if (state is LoadingSubmitOrCheckNilai) {
                TgzDialogLoading().loadingDialog(context,
                    text: 'Sedang mengirim data ke server');
              }

              if (state is SubmitSuccessOrNot) {
                Navigator.pop(context);
                if (state.isSuccess) {
                  TgzDialogConfirm()
                      .confirmOneButton(context, state.message)
                      .then((value) {
                    _logicCubit.refreshSubmitted();
                  });
                } else {
                  TgzDialogError().warningOneButton(context, state.message);
                }
              }
            },
            child: BlocBuilder<PenilainsfCubit, PenilainsfState>(
              builder: (context, state) {
                double? nilaiTotal = state.nilai;
                PenilaianSf penilaianSf = state.penilaianSf;
                ph("$state nilai $nilaiTotal");
                return state.isSubmitted
                    ? const WidgetSucces()
                    : Column(
                        children: [
                          CardPertanyaanSF(
                              ePenilaianSF: EPenilaianSF.personalities,
                              penilaianSf: penilaianSf),
                          CardPertanyaanSF(
                              ePenilaianSF: EPenilaianSF.distribution,
                              penilaianSf: penilaianSf),
                          CardPertanyaanSF(
                              ePenilaianSF: EPenilaianSF.merchandising,
                              penilaianSf: penilaianSf),
                          CardPertanyaanSF(
                              ePenilaianSF: EPenilaianSF.promotion,
                              penilaianSf: penilaianSf),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                ButtonApp.green('Cek Nilai', () {
                                  _cListener.tryToCheckNilai(
                                      penilaianSf, widget.idSF);
                                }),
                                const Spacer(),
                                LabelBlack.title('${nilaiTotal ?? '-'}'),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          TextArea(
                            onChangeText: (value) {
                              _logicCubit.changeMessage(value);
                            },
                            controller: _messageController,
                            label: 'Comment',
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ButtonStrectWidth(
                                buttonColor: Colors.red,
                                text: 'Submit',
                                onTap: () {
                                  _cListener.trySubmit(
                                      penilaianSf, widget.idSF);
                                },
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
      title: widget.idSF,
    );
  }
}
