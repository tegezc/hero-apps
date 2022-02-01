import 'package:flutter/material.dart';
import 'package:hero/module_mt/domain/entity/common/outlet_mt.dart';
import 'package:hero/util/component/label/component_label.dart';

class CellOutlet extends StatelessWidget {
  final Function onTap;
  final OutletMT outletMT;
  const CellOutlet({Key? key, required this.onTap, required this.outletMT})
      : super(key: key);

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
                  LabelWhite.size3(outletMT.idDigipos),
                  const SizedBox(
                    height: 5,
                  ),
                  LabelWhite.size3(outletMT.namaOutlet),
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
