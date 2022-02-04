import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/question.dart';
import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/questions.dart';
import 'package:hero/module_mt/presentation/common/penilaian_outlet/parent_tab/cubit/penilaianoutlet_cubit.dart';
import 'package:hero/module_mt/presentation/common/widgets/label_multiline.dart';
import 'package:hero/util/component/label/component_label.dart';

class CardQuestion extends StatefulWidget {
  final Questions questions;
  const CardQuestion({Key? key, required this.questions}) : super(key: key);

  @override
  _CardQuestionState createState() => _CardQuestionState();
}

class _CardQuestionState extends State<CardQuestion> {
  List<bool> switchedValue = [];
  @override
  void initState() {
    for (var i = 0; i < widget.questions.lquestion.length; i++) {
      switchedValue.add(widget.questions.lquestion[i].isYes);
    }
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
    Questions q = widget.questions;

    List<Widget> lw = [];
    lw.add(const LabelBlack.size1('Question'));
    lw.add(const Divider());
    for (int i = 0; i < q.lquestion.length; i++) {
      Question p = q.lquestion[i];
      lw.add(_cellQuestion(p, i));
      lw.add(const Divider());
    }
    lw.add(const SizedBox(
      height: 8,
    ));
    return lw;
  }

  Widget _cellQuestion(Question p, int index) {
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
          child: _radioButton(index),
        ),
      ],
    );
  }

  Widget _radioButton(int index) {
    return Row(
      children: [
        Switch(
          value: switchedValue[index],
          onChanged: (value) {
            BlocProvider.of<PenilaianoutletCubit>(context)
                .changeSwitchedToggleAvailibity(index, value);
            setState(() {
              switchedValue[index] = value;
            });
          },
          activeTrackColor: Colors.lightGreenAccent,
          activeColor: Colors.green,
        ),
        LabelBlack.size1(switchedValue[index] ? 'Yes' : 'No'),
      ],
    );
  }
}
