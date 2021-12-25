import 'package:flutter/material.dart';
import 'package:hero/model/enumapp.dart';
import 'package:hero/modulapp/coverage/blochomecoverage.dart';
import 'package:hero/modulapp/coverage/searchlocation/locationditolak.dart';

class CoverageHome extends StatefulWidget {
  @override
  _CoverageHomeState createState() => _CoverageHomeState();
}

class _CoverageHomeState extends State<CoverageHome> {
  BlocHomePageCoverage? _blocDashboard;
  int _counterBuild = 0;
  @override
  void initState() {
    _blocDashboard = BlocHomePageCoverage();
    super.initState();
  }

  @override
  void dispose() {
    _blocDashboard!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (_counterBuild == 0) {
      _blocDashboard!.firstTime();
      _counterBuild++;
    }

    return StreamBuilder<UIHomeCvrg?>(
        stream: _blocDashboard!.uihpcvrg,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }

          UIHomeCvrg item = snapshot.data!;
          if (item.enumStateWidget == EnumStateWidget.loading) {
            return LocationDitolak(_blocDashboard);
          } else if (item.enumStateWidget == EnumStateWidget.startup) {
            return Container();
          }
          return Stack(children: [
            SingleChildScrollView(
              child: Container(
                height: size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FractionallySizedBox(
                        widthFactor: 1,
                        child: Image(
                            image: AssetImage('assets/image/coverage/BG.png'))),
                  ],
                ),
              ),
            )
          ]);
        });
  }
}
