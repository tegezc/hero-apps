import 'package:flutter/material.dart';
import 'package:hero/module_mt/presentation/common/widgets/cell_widget.dart';

class InfoOutlet extends StatelessWidget {
  const InfoOutlet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double widthLabel = 70.0;
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CellDuaColumn(
              label: 'Cluster',
              widthFirsComponent: widthLabel,
              value: 'Cluster I',
            ),
            _space(),
            CellDuaColumn(
              label: 'TAP',
              widthFirsComponent: widthLabel,
              value: 'Tap I',
            ),
            _space(),
            CellDuaColumn(
              label: 'No Hp',
              widthFirsComponent: widthLabel,
              value: '081233332222',
            ),
          ],
        ),
      ),
    );
  }

  Widget _space() {
    return const SizedBox(
      height: 5,
    );
  }
}
