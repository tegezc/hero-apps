import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/kategories.dart';
import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/param_penilaian.dart';
import 'package:hero/module_mt/presentation/common/penilaian_outlet/parent_tab/cubit/penilaianoutlet_cubit.dart';
import 'package:hero/module_mt/presentation/tandem_selling/common/widget_textfield_withlabel.dart';
import 'package:hero/util/component/button/component_button.dart';
import 'package:hero/util/component/label/component_label.dart';

class CardTableParameter extends StatefulWidget {
  final Kategories kategories;
  final EJenisParam eJenisParam;
  const CardTableParameter({
    Key? key,
    required this.kategories,
    required this.eJenisParam,
  }) : super(key: key);

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
                  .changeTextAvailibity(i, value, widget.eJenisParam);
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
        child: ButtonStrectWidth(
            buttonColor: Colors.green,
            text: 'Ambil Photo',
            onTap: () {},
            isenable: true),
      ),
    );
    return lw;
  }
}
