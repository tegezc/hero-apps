import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero/module_mt/domain/entity/common/sales.dart';
import 'package:hero/module_mt/domain/entity/tandem_selling/penilaian_sf.dart';
import 'package:hero/module_mt/presentation/common/widgets/page_err_loading/page_mt_error.dart';
import 'package:hero/module_mt/presentation/common/widgets/page_err_loading/page_loading_mt.dart';
import 'package:hero/module_mt/presentation/tandem_selling/penilaian_sf/page_penilaian_sf.dart';
import 'package:hero/module_mt/presentation/tandem_selling/penilaian_sf/page_state/page_parent_cubit.dart';
import 'package:hero/util/component/widget/component_widget.dart';

class HpPenilaianSf extends StatefulWidget {
  const HpPenilaianSf({Key? key, required this.sales}) : super(key: key);
  final Sales sales;

  @override
  _HpPenilaianSfState createState() => _HpPenilaianSfState();
}

class _HpPenilaianSfState extends State<HpPenilaianSf> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PageParentCubit()..setupData(widget.sales.idSales),
      child: BlocBuilder<PageParentCubit, PageParentPenilaianSFState>(
        builder: (context, state) {
          if (state is PageParentPenilaianSFInitial) {
            return ScaffoldMT(body: Container(), title: 'Loading..');
          }
          if (state is PageParentPenilaianSfError) {
            return PageMtError(message: state.message);
          }
          if (state is PageParentPenilaianSfLoading) {
            return const LoadingNungguMT(
                'Sedang mengambil data.\nMohon menunggu.');
          }

          if (state is PageParentPenilaianSfLoaded) {
            PageParentPenilaianSfLoaded item = state;
            PenilaianSf penilaianSf = item.penilaianSf;
            return PagePenilaianSf(penilaianSf: penilaianSf);
          }

          return ScaffoldMT(body: Container(), title: 'Error..');
        },
      ),
    );
  }
}
