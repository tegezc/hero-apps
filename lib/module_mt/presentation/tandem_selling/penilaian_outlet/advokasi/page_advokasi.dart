import 'package:flutter/material.dart';
import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/advokasi.dart';
import 'package:hero/util/component/button/component_button.dart';

import 'card_question_list.dart';

class PageAdvokasi extends StatefulWidget {
  const PageAdvokasi({Key? key, required this.advokasi}) : super(key: key);
  final Advokasi advokasi;

  @override
  _PageAdvokasiState createState() => _PageAdvokasiState();
}

class _PageAdvokasiState extends State<PageAdvokasi> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CardQuestionList(questions: widget.advokasi.lquestions),
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
