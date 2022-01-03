import 'package:flutter/material.dart';
import 'package:hero/model/enumapp.dart';
import 'package:hero/model/merchandising/merchandising.dart';
import 'package:hero/util/component/component_label.dart';
import 'package:hero/util/component/component_widget.dart';

class ViewMerchandising extends StatefulWidget {
  final EnumMerchandising enumMerchandising;
  final Merchandising? merchandising;
  ViewMerchandising(this.enumMerchandising, this.merchandising);
  @override
  _ViewMerchandisingState createState() => _ViewMerchandisingState();
}

class _ViewMerchandisingState extends State<ViewMerchandising> {
  String? _title;
  Merchandising? _m;
  @override
  void initState() {
    _m = widget.merchandising;
    switch (widget.enumMerchandising) {
      case EnumMerchandising.etalase:
        _title = 'Etalase';
        break;
      case EnumMerchandising.spanduk:
        _title = 'Spanduk';
        break;
      case EnumMerchandising.poster:
        _title = 'Poster';
        break;
      case EnumMerchandising.papan:
        _title = 'Papan';
        break;
      case EnumMerchandising.backdrop:
        _title = 'Backdrop';
        break;
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    if (_m == null) {
      return Container();
    }
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: s.width,
            height: s.height - 130,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                        child: Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 8),
                      child: LabelBlack.title(
                        _title,
                        bold: true,
                      ),
                    )),
                    _cardForm(s.width),
                    SizedBox(
                      height: 10,
                    ),
                    _listPhoto(
                        s.width, _m!.pathPhoto1, _m!.pathPhoto2, _m!.pathPhoto3),
                    SizedBox(
                      height: 100,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardForm(double width) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _cellForm('Telkomsel', _m!.telkomsel),
            _cellForm('Isat', _m!.isat),
            _cellForm('XL', _m!.xl),
            _cellForm('3', _m!.tri),
            _cellForm('Smartfren', _m!.sf),
            _cellForm('Axis', _m!.axis),
            _cellForm('Other', _m!.other),
          ],
        ),
      ),
    );
  }

  Widget _cellForm(String label, int? jumlah) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          SizedBox(width: 80, child: LabelBlack.size2(label)),
          LabelBlack.size2(': '),
          LabelBlack.size2('$jumlah')
        ],
      ),
    );
  }

  Widget _listPhoto(
    double width,
    String? path1,
    String? path2,
    String? path3,
  ) {
    return Card(
      child: Wrap(
        direction: Axis.horizontal,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ContainerRounded(
              borderColor: Colors.black,
              radius: 4.0,
              child: FractionallySizedBox(
                  widthFactor: 0.9, child: _showImage(path1)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ContainerRounded(
              borderColor: Colors.black,
              radius: 4.0,
              child: FractionallySizedBox(
                  widthFactor: 0.9, child: _showImage(path2)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ContainerRounded(
              borderColor: Colors.black,
              radius: 4.0,
              child: FractionallySizedBox(
                  widthFactor: 0.9, child: _showImage(path3)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _showImage(String? url) {
    if (url == null) {
      return Container();
    }
    return Image.network(
      url,
      errorBuilder:
          (BuildContext context, Object exception, StackTrace? stackTrace) {
        return Container();
      },
    );
  }
}
