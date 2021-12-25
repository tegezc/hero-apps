import 'package:flutter/material.dart';
import 'package:hero/util/component/component_button.dart';
import 'package:hero/util/component/component_label.dart';

import '../blochomecoverage.dart';

class LocationDitolak extends StatefulWidget {
  final BlocHomePageCoverage? blocDashboard;
  LocationDitolak(this.blocDashboard);
  @override
  _LocationDitolakState createState() => _LocationDitolakState();
}

class _LocationDitolakState extends State<LocationDitolak> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 150,
            ),
            LabelApp.size1('Aplikasi ini tidak dapat digunakan tanpa '),
            SizedBox(
              height: 8,
            ),
            LabelApp.size1(
              'ijin akses lokasi.',
              color: Colors.red,
            ),
            SizedBox(
              height: 8,
            ),
            ButtonApp.blue('Ijinkan Akses Lokasi', () {
              widget.blocDashboard!.requestIjinLokasi().then((value) {
                if (!value) {
                  _confirmGagalLokasi();
                }
              });
            }),
          ],
        ),
      ),
    );
  }

  _confirmGagalLokasi() {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => SimpleDialog(
              title: LabelApp.size1(
                'Confirm',
                color: Colors.red,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0, left: 16.0, bottom: 3.0),
                  child: LabelBlack.size2('Aplikasi ini butuh akses lokasi'),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0, left: 16.0, bottom: 3.0),
                  child: ButtonApp.black('Ok', () {
                    Navigator.of(context).pop();
                  }),
                ),
              ],
            ));
  }
}
