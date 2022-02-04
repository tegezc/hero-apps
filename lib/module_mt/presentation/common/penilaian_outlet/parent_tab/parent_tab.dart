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
  ParentTabNilaiOutlet(
      {Key? key,
      required this.cacheAvailibility,
      required this.cacheVisibility,
      required this.cacheAdvokasi})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => PenilaianoutletCubit(
          availibility: cacheAvailibility,
          visibility: cacheVisibility,
          advokasi: cacheAdvokasi),
      child: BlocListener<PenilaianoutletCubit, PenilaianoutletState>(
        listener: (context, state) {},
        child: BlocBuilder<PenilaianoutletCubit, PenilaianoutletState>(
          builder: (context, state) {
            return TabBarView(
              children: [
                PageAvailability(
                  availability: cacheAvailibility,
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
