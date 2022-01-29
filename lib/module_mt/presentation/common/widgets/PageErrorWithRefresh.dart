import 'package:flutter/material.dart';
import 'package:hero/util/component/label/component_label.dart';
import 'package:hero/util/component/widget/component_widget.dart';

class PageErrorWithRefresh extends StatelessWidget {
  final Function onRefresh;
  final String message;
  const PageErrorWithRefresh(
      {Key? key, required this.onRefresh, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldMT(
      body: Column(
        children: [
          const Spacer(),
          LabelBlack.title(message),
          Center(
            child: IconButton(
                onPressed: () {
                  onRefresh();
                },
                icon: const Icon(Icons.refresh_rounded)),
          ),
          const Spacer(),
        ],
      ),
      title: 'Page Error',
    );
  }
}
