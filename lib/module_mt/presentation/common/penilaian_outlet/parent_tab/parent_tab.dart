import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero/module_mt/domain/entity/common/outlet_mt.dart';
import 'package:hero/module_mt/presentation/common/widgets/Page_mt_error.dart';
import 'package:hero/module_mt/presentation/tandem_selling/penilaian_outlet/advokasi/page_advokasi.dart';
import 'package:hero/module_mt/presentation/tandem_selling/penilaian_outlet/availability/page_availability.dart';
import 'package:hero/module_mt/presentation/tandem_selling/penilaian_outlet/parent_tab/cubit/penilaianoutlet_cubit.dart';
import 'package:hero/module_mt/presentation/tandem_selling/penilaian_outlet/visibility/page_visibility.dart';
import 'package:hero/util/component/button/component_button.dart';
import 'package:hero/util/component/label/component_label.dart';
import 'package:hero/util/component/widget/component_widget.dart';

class ParentTabNilaiOutlet extends StatefulWidget {
  static const routeName = '/nilaioutlet';
  final OutletMT outletMT;
  const ParentTabNilaiOutlet({required this.outletMT, Key? key})
      : super(key: key);

  @override
  _ParentTabNilaiOutletState createState() => _ParentTabNilaiOutletState();
}

class _ParentTabNilaiOutletState extends State<ParentTabNilaiOutlet> {
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
          create: (context) =>
              PenilaianoutletCubit()..setupData(widget.outletMT.idOutlet),
          child: BlocBuilder<PenilaianoutletCubit, PenilaianoutletState>(
            builder: (context, state) {
              if (state is PenilaianoutletLoading) {
                return ScaffoldMT(body: Container(), title: 'Loading..');
              }

              if (state is PenilaianoutletError) {
                return const PageMtError(message: 'Terjadi kesalahan');
              }

              if (state is PenilaianoutletLoaded) {
                PenilaianoutletLoaded item = state;
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
                  body: TabBarView(
                    children: [
                      PageAvailability(
                        availability: item.availability,
                      ),
                      PageVisibility(penilaianVisibility: item.visibility),
                      PageAdvokasi(
                        advokasi: item.advokasi,
                      ),
                    ],
                  ),
                );
              }

              return const PageMtError(message: 'Terjadi Kesalahan');
            },
          ),
        ),
      ),
    );
  }
}
