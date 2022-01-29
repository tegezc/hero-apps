import 'package:flutter/material.dart';
import 'package:hero/module_mt/presentation/tandem_selling/detail_outlet/widget_info_outlet.dart';
import 'package:hero/util/component/button/component_button.dart';
import 'package:hero/util/component/widget/component_widget.dart';

class DetailOutlet extends StatefulWidget {
  const DetailOutlet({Key? key}) : super(key: key);

  @override
  _DetailOutletState createState() => _DetailOutletState();
}

class _DetailOutletState extends State<DetailOutlet> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldMT(
        body: SingleChildScrollView(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InfoOutlet(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ButtonStrectWidth(
                  buttonColor: Colors.green,
                  text: 'Check Long Lat',
                  onTap: () {},
                  isenable: true),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ButtonStrectWidth(
                  buttonColor: Colors.green,
                  text: 'Penilain Outlet',
                  onTap: () {},
                  isenable: true),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ButtonStrectWidth(
                  buttonColor: Colors.green,
                  text: 'Voice of Retailer',
                  onTap: () {},
                  isenable: true),
            ),
          ],
        )),
        title: 'Cell Bintang');
  }
}
