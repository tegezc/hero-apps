import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/question.dart';
import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/questions.dart';
import 'package:hero/module_mt/presentation/common/widgets/label_multiline.dart';
import 'package:hero/module_mt/presentation/tandem_selling/penilaian_outlet/parent_tab/cubit/penilaianoutlet_cubit.dart';
import 'package:hero/util/component/label/component_label.dart';

class CardQuestionSingle extends StatefulWidget {
  final Question question;
  const CardQuestionSingle({Key? key, required this.question})
      : super(key: key);

  @override
  _CardQuestionState createState() => _CardQuestionState();
}

class _CardQuestionState extends State<CardQuestionSingle> {
  bool switchedValue = true;
  @override
  void initState() {
    switchedValue = widget.question.isYes ?? true;
    super.initState();
  }

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
    Question q = widget.question;

    List<Widget> lw = [];
    lw.add(const LabelBlack.size1('Question'));
    lw.add(const Divider());

    lw.add(_cellQuestion(q));
    lw.add(const Divider());

    lw.add(const SizedBox(
      height: 8,
    ));
    return lw;
  }

  Widget _cellQuestion(Question p) {
    Size s = MediaQuery.of(context).size;
    double widthLabel = s.width - 125;
    double widthTextField = 100;
    return Row(
      children: [
        SizedBox(
          width: widthLabel,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: LabelMultiline(p.pertanyaan),
          ),
        ),
        SizedBox(
          width: widthTextField,
          child: _radioButton(),
        ),
      ],
    );
  }

  Widget _radioButton() {
    return Row(
      children: [
        Switch(
          value: switchedValue,
          onChanged: (value) {
            // BlocProvider.of<PenilaianoutletCubit>(context)
            //     .changeSwitchedToggleAvailibity(index, value);
            setState(() {
              switchedValue = value;
            });
          },
          activeTrackColor: Colors.lightGreenAccent,
          activeColor: Colors.green,
        ),
        LabelBlack.size1(switchedValue ? 'Yes' : 'No'),
      ],
    );
  }
}
