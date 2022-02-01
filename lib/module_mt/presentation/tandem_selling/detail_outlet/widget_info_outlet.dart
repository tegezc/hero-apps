import 'package:flutter/material.dart';
import 'package:hero/module_mt/domain/entity/common/outlet_mt.dart';
import 'package:hero/module_mt/presentation/common/widgets/cell_widget.dart';

class InfoOutlet extends StatelessWidget {
  final OutletMT outletMT;
  final String cluster;
  final String tap;
  InfoOutlet(
      {Key? key,
      required this.outletMT,
      required this.cluster,
      required this.tap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double widthLabel = 70.0;
//     I/flutter (18350): ║                 nama_outlet: "OUTLET J",
// I/flutter (18350): ║                 no_rs: "6282185172939",
// I/flutter (18350): ║                 id_sales: "SSF0018",
// I/flutter (18350): ║                 nama_sales: "Afiqa Shofia Putri",
// I/flutter (18350): ║                 longitude: "106.5301711",
// I/flutter (18350): ║                 latitude: "-6.2704553",
// I/flutter (18350): ║                 radius_clock_in: "100"

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CellDuaColumn(
              label: 'Cluster',
              widthFirsComponent: widthLabel,
              value: cluster,
            ),
            _space(),
            CellDuaColumn(
              label: 'TAP',
              widthFirsComponent: widthLabel,
              value: tap,
            ),
            _space(),
            CellDuaColumn(
              label: 'Nama',
              widthFirsComponent: widthLabel,
              value: outletMT.namaOutlet,
            ),
            _space(),
            CellDuaColumn(
              label: 'No RS',
              widthFirsComponent: widthLabel,
              value: outletMT.noRs,
            ),
            const Divider(),
            CellDuaColumn(
              label: 'Id Sales',
              widthFirsComponent: widthLabel,
              value: outletMT.idSales,
            ),
            _space(),
            CellDuaColumn(
              label: 'Sales',
              widthFirsComponent: widthLabel,
              value: outletMT.namaSales,
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
