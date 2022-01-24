import 'package:flutter/material.dart';
import 'package:hero/util/component/button/component_button.dart';
import 'package:hero/util/component/label/component_label.dart';
import 'package:hero/util/component/widget/component_widget.dart';
import 'package:loading_animations/loading_animations.dart';

class LoadingNunggu extends StatelessWidget {
  final String strContent;

  LoadingNunggu(this.strContent);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return CustomScaffold(
        title: 'Loading...',
        body: Container(
          width: mediaQueryData.size.width,
          height: mediaQueryData.size.height,
          color: Colors.white,
          child: Center(
              child: Column(
            children: [
              LoadingBouncingLine.circle(backgroundColor: Colors.deepOrange),
              Text(strContent,
                  style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
            ],
          )),
        ));
  }
}

class BelumAdaData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan[600],
          title: Text('Google Drive'),
        ),
        body: Center(child: Text('Belum ada data kontrak.')));
  }
}

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan[600],
          title: Text('Google Drive'),
        ),
        body: Center(child: Text('Terjadi Kesalahan')));
  }
}
