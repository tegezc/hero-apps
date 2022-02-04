import 'package:flutter/material.dart';
import 'package:hero/module_mt/domain/entity/common/penilaian_outlet/visibility.dart';
import 'package:hero/module_mt/presentation/common/penilaian_outlet/availability/card_table.dart';
import 'package:hero/module_mt/presentation/common/widgets/image_file.dart';
import 'package:hero/util/component/button/component_button.dart';
import 'package:hero/util/uiutil.dart';

import '../enum_penilaian.dart';
import '../penilaian_take_photo.dart';
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
            eJenisParam: EJenisParam.poster,
            ePhoto: EPhotoPenilaian.poster,
            pathImage: widget.penilaianVisibility.imagePoster,
          ),
          const SizedBox(
            height: 8,
          ),
          CardTableParameter(
            kategories: widget.penilaianVisibility.kategoriesLayar,
            eJenisParam: EJenisParam.layar,
            ePhoto: EPhotoPenilaian.layar,
            pathImage: widget.penilaianVisibility.imageLayar,
          ),
          const SizedBox(
            height: 8,
          ),
          CardQuestionSingle(
              question: widget.penilaianVisibility.questionBawah),
          const SizedBox(
            height: 8.0,
          ),
          widget.penilaianVisibility.imageEtalase == null
              ? ButtonStrectWidth(
                  buttonColor: Colors.green,
                  text: 'Ambil Photo',
                  onTap: () {
                    CommonUi()
                        .openPage(context, const PenilaianTakePhoto())
                        .then((value) {
                      if (value != null) {}
                    });
                  },
                  isenable: true)
              : ImageFile(pathPhoto: widget.penilaianVisibility.imageEtalase),
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
