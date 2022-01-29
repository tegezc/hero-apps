import 'package:flutter/material.dart';
import 'package:hero/util/component/label/component_label.dart';

class CellOutlet extends StatelessWidget {
  final Function onTap;
  const CellOutlet({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        onTap();
      },
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.store,
                color: Colors.white,
              ),
              const SizedBox(
                width: 12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LabelWhite.size3('0387888'),
                  const SizedBox(
                    height: 5,
                  ),
                  LabelWhite.size3('Cell Bintang'),
                ],
              ),
              const Spacer(),
              const Icon(
                Icons.play_circle_outline,
                color: Colors.white,
              ),
            ],
          ),
          const SizedBox(height: 5),
          Divider(color: Colors.grey[400]),
        ],
      ),
    );
  }
}
