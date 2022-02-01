import 'package:flutter/material.dart';
import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/visibility.dart';
import 'package:hero/module_mt/presentation/tandem_selling/penilaian_outlet/availability/card_question.dart';
import 'package:hero/module_mt/presentation/tandem_selling/penilaian_outlet/availability/card_table.dart';
import 'package:hero/module_mt/presentation/tandem_selling/penilaian_outlet/parent_tab/cubit/penilaianoutlet_cubit.dart';
import 'package:hero/util/component/button/component_button.dart';

import 'card_question_single.dart';

class PageVisibility extends StatefulWidget {
  const PageVisibility({Key? key, required this.penilaianVisibility})
      : super(key: key);
  final PenilaianVisibility penilaianVisibility;

  @override
  _PageVisibilityState createState() => _PageVisibilityState();
}

class _PageVisibilityState extends State<PageVisibility> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CardQuestionSingle(question: widget.penilaianVisibility.questionAtas),
          const SizedBox(
            height: 8,
          ),
          CardTableParameter(
              kategories: widget.penilaianVisibility.kategoriesPoster,
              eJenisParam: EJenisParam.poster),
          const SizedBox(
            height: 8,
          ),
          CardTableParameter(
            kategories: widget.penilaianVisibility.kategoriesLayar,
            eJenisParam: EJenisParam.layar,
          ),
          const SizedBox(
            height: 8,
          ),
          CardQuestionSingle(
              question: widget.penilaianVisibility.questionBawah),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ButtonStrectWidth(
                buttonColor: Colors.red,
                text: 'Submit',
                onTap: () {},
                isenable: true),
          ),
          const SizedBox(
            height: 80,
          ),
        ],
      ),
    );
  }
}
