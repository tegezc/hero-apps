import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/advokasi.dart';
import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/availability.dart';
import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/visibility.dart';
import 'package:hero/module_mt/presentation/common/penilaian_outlet/advokasi/page_advokasi.dart';
import 'package:hero/module_mt/presentation/common/penilaian_outlet/availability/page_availability.dart';
import 'package:hero/module_mt/presentation/common/penilaian_outlet/visibility/page_visibility.dart';

import 'cubit/penilaianoutlet_cubit.dart';

class ParentTabNilaiOutlet extends StatelessWidget {
  static const routeName = '/nilaioutlet';
  final Availability cacheAvailibility;
  final PenilaianVisibility cacheVisibility;
  final Advokasi cacheAdvokasi;
  final String idOutlet;

  ParentTabNilaiOutlet(
      {Key? key,
      required this.cacheAvailibility,
      required this.cacheVisibility,
      required this.cacheAdvokasi,
      required this.idOutlet})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => PenilaianoutletCubit(
          availability: cacheAvailibility,
          visibility: cacheVisibility,
          advokasi: cacheAdvokasi,
          idOutlet: idOutlet),
      child: BlocListener<PenilaianoutletCubit, PenilaianoutletState>(
        listener: (context, state) {
          // if (state is LoadingSubmitData) {
          //   TgzDialogLoading()
          //       .loadingDialog(context, text: 'Sedang Submit data');
          // }
          // if (state is ConfirmSubmit) {
          //   TgzDialogConfirm().confirmTwoButton(
          //       context, "Apakah anda yakin akan submit data", () {
          //     BlocProvider.of<PenilaianoutletCubit>(context).submit(state.eTab);
          //   });
          // }
          //
          // if (state is FieldNotValidState) {
          //   TgzDialogError()
          //       .warningOneButton(context, 'Semua field harus di isi.');
          // }
        },
        child: BlocBuilder<PenilaianoutletCubit, PenilaianoutletState>(
          builder: (context, state) {
            return TabBarView(
              children: [
                PageAvailability(
                  availability: cacheAvailibility,
                  idOutlet: idOutlet,
                ),
                PageVisibility(penilaianVisibility: cacheVisibility),
                PageAdvokasi(
                  advokasi: cacheAdvokasi,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
