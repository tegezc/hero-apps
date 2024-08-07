import 'package:flutter/material.dart';
import 'package:hero/util/component/button/component_button.dart';
import 'package:hero/util/component/label/component_label.dart';

import '../blochomecoverage.dart';

class LocationDitolak extends StatefulWidget {
  final BlocHomePageCoverage? blocDashboard;
  const LocationDitolak(this.blocDashboard, {Key? key}) : super(key: key);
  @override
  _LocationDitolakState createState() => _LocationDitolakState();
}

class _LocationDitolakState extends State<LocationDitolak> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(
            height: 150,
          ),
          const LabelApp.size1('Aplikasi ini tidak dapat digunakan tanpa '),
          const SizedBox(
            height: 8,
          ),
          const LabelApp.size1(
            'ijin akses location.',
            color: Colors.red,
          ),
          const SizedBox(
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
    );
  }

  _confirmGagalLokasi() {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => SimpleDialog(
              title: const LabelApp.size1(
                'Confirm',
                color: Colors.red,
              ),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              children: <Widget>[
                const Padding(
                  padding:
                      EdgeInsets.only(right: 16.0, left: 16.0, bottom: 3.0),
                  child: LabelBlack.size2('Aplikasi ini butuh akses location'),
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
