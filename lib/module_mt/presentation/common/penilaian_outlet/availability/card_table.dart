import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/kategories.dart';
import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/param_penilaian.dart';
import 'package:hero/module_mt/presentation/common/penilaian_outlet/parent_tab/cubit/penilaianoutlet_cubit.dart';
import 'package:hero/module_mt/presentation/common/widgets/image_file.dart';
import 'package:hero/module_mt/presentation/tandem_selling/common/widget_textfield_withlabel.dart';
import 'package:hero/util/component/button/component_button.dart';
import 'package:hero/util/component/label/component_label.dart';
import 'package:hero/util/uiutil.dart';

import '../enum_penilaian.dart';
import '../penilaian_take_photo.dart';

class CardTableParameter extends StatefulWidget {
  final Kategories kategories;
  final EJenisParam eJenisParam;
  final EPhotoPenilaian ePhoto;
  final String? pathImage;
  const CardTableParameter(
      {Key? key,
      required this.kategories,
      required this.ePhoto,
      required this.eJenisParam,
      required this.pathImage})
      : super(key: key);

  @override
  _CardTableParameterState createState() => _CardTableParameterState();
}

class _CardTableParameterState extends State<CardTableParameter> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 2,
        child: Column(
          children: _recordsParam(),
        ),
      ),
    );
  }

  List<Widget> _recordsParam() {
    Kategories k = widget.kategories;

    Size s = MediaQuery.of(context).size;
    double widthLabel = s.width - 150;
    double widthTextField = 80;
    List<Widget> lw = [];
    lw.add(LabelBlack.size1(k.kategori));
    lw.add(const Divider());
    for (int i = 0; i < k.lparams.length; i++) {
      ParamPenilaian p = k.lparams[i];
      lw.add(Padding(
        padding: const EdgeInsets.only(left: 8.0, top: 4, bottom: 4),
        child: TextFieldNumberOnlyWithLabel(
            widthLabel: widthLabel,
            widthTextField: widthTextField,
            onChanged: (value) {
              BlocProvider.of<PenilaianoutletCubit>(context)
                  .changeTextPenilaian(i, value, widget.eJenisParam);
            },
            // controller: _controller,
            label: p.param),
      ));
    }
    lw.add(const SizedBox(
      height: 8,
    ));
    lw.add(
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: widget.pathImage == null
            ? ButtonStrectWidth(
                buttonColor: Colors.green,
                text: 'Ambil Photo',
                onTap: () {
                  CommonUi()
                      .openPage(context, const PenilaianTakePhoto())
                      .then((value) {
                    if (value != null) {
                      if (value is String) {
                        BlocProvider.of<PenilaianoutletCubit>(context)
                            .setPathImage(value, widget.ePhoto);
                      }
                    }
                  });
                },
                isenable: true)
            : ImageFile(pathPhoto: widget.pathImage),
      ),
    );
    return lw;
  }
}
