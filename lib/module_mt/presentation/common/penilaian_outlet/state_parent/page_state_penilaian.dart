import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero/module_mt/domain/entity/common/outlet_mt.dart';
import 'package:hero/module_mt/presentation/common/e_kegiatan_mt.dart';
import 'package:hero/module_mt/presentation/common/penilaian_outlet/parent_tab/parent_tab.dart';
import 'package:hero/module_mt/presentation/common/widgets/page_err_loading/page_mt_error.dart';
import 'package:hero/util/component/label/component_label.dart';
import 'package:hero/util/component/widget/component_widget.dart';

import 'cubit/statepenilaian_cubit.dart';

class ParentStatePenilaian extends StatefulWidget {
  static const routeName = '/nilaioutlet';
  final OutletMT outletMT;
  final EKegitatanMt eKegiatanMt;
  const ParentStatePenilaian(
      {required this.outletMT, Key? key, required this.eKegiatanMt})
      : super(key: key);

  @override
  _ParentStatePenilaianState createState() => _ParentStatePenilaianState();
}

class _ParentStatePenilaianState extends State<ParentStatePenilaian> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: BlocProvider(
          create: (context) => StatepenilaianCubit()
            ..setupData(widget.outletMT, widget.eKegiatanMt),
          child: BlocBuilder<StatepenilaianCubit, StatepenilaianState>(
            builder: (context, state) {
              if (state is StatepenilaianInitial) {
                return ScaffoldMT(body: Container(), title: 'Loading..');
              }
              if (state is StatepenilaianLoading) {
                return ScaffoldMT(body: Container(), title: 'Loading..');
              }

              if (state is StatepenilaianError) {
                return const PageMtError(message: 'Terjadi kesalahan');
              }

              if (state is StatepenilaianLoaded) {
                StatepenilaianLoaded item = state;
                return Scaffold(
                  appBar: AppBar(
                    bottom: const TabBar(
                      indicatorColor: Colors.white,
                      isScrollable: true,
                      tabs: [
                        // wallet share, sales broadband share, voucher fisik share
                        Tab(
                          child: LabelWhite.size2('Availability'),
                        ),
                        Tab(
                          child: LabelWhite.size2('Visibility'),
                        ),
                        Tab(
                          child: LabelWhite.size2('Advokasi'),
                        ),
                      ],
                    ),
                    backgroundColor: Colors.red[600],
                    iconTheme: const IconThemeData(
                      color: Colors.white, //change your color here
                    ),
                    title: const Text(
                      'Penilaian Outlet',
                      style: TextStyle(color: Colors.white),
                    ),
                    centerTitle: true,
                  ),
                  body: ParentTabNilaiOutlet(
                    cacheAvailibility: item.availability,
                    cacheVisibility: item.visibility,
                    cacheAdvokasi: item.advokasi,
                    outletMT: item.outletMT,
                    eKegitatanMt: item.eKegitatanMt,
                  ),
                );
              }

              return const PageMtError(message: 'Error');
            },
          ),
        ),
      ),
    );
  }
}
