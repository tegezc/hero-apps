import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero/module_mt/domain/entity/common/outlet_mt.dart';
import 'package:hero/module_mt/presentation/common/e_kegiatan_mt.dart';
import 'package:hero/module_mt/presentation/common/voice_of_reseller/page_vor.dart';
import 'package:hero/module_mt/presentation/common/widgets/page_err_loading/page_mt_error.dart';
import 'package:hero/module_mt/presentation/common/widgets/page_err_loading/page_loading_mt.dart';

import 'cubit_parent/voiceofreseller_cubit.dart';

class HPVoiceOfRetailer extends StatefulWidget {
  final OutletMT outletMT;
  final EKegitatanMt eKegitatanMt;
  const HPVoiceOfRetailer({Key? key, required this.outletMT,required this.eKegitatanMt}) : super(key: key);

  @override
  _HPVoiceOfRetailerState createState() => _HPVoiceOfRetailerState();
}

class _HPVoiceOfRetailerState extends State<HPVoiceOfRetailer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          VoiceofresellerCubit()..setupData(widget.outletMT),
      child: BlocBuilder<VoiceofresellerCubit, VoiceofresellerState>(
        builder: (context, state) {
          if (state is VoiceofresellerError) {
            return PageMtError(
              message: state.message,
            );
          }

          if (state is VoiceofresellerLoading ||
              state is VoiceofresellerInitial) {
            return const LoadingNungguMT(
                'Sedang mendapatkan data.\nMohon menunggu...');
          }

          if (state is VoiceofresellerLoaded) {
            return PageVoiceOfReseller(
              vor: state.voiceOfReseller!,
              outletMT: state.outletMT,
              eKegitatanMt: widget.eKegitatanMt,

            );
          }
          return const PageMtError(message: 'Terjadi kesalahan');
        },
      ),
    );
  }
}
