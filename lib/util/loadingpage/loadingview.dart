import 'package:flutter/material.dart';
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
                  style: TextStyle(
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
          title: Text(''),
        ),
        body: Center(child: Text('Belum ada data ')));
  }
}

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan[600],
          title: Text(''),
        ),
        body: Center(child: Text('Terjadi Kesalahan')));
  }
}

class LoadingTransparan extends StatelessWidget {
  final String strContent;

  LoadingTransparan(this.strContent);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Opacity(
              opacity: 0.5,
              child: Container(
                color: Colors.grey[200],
                width: mediaQueryData.size.width,
                height: mediaQueryData.size.height,
              ),
            ),
            Container(
              width: mediaQueryData.size.width,
              height: mediaQueryData.size.height,
              child: Center(
                  child: Column(
                children: [
                  SizedBox(
                    height: 200,
                  ),
                  _contentLoading(),
                ],
              )),
            ),
          ],
        ));
  }

  Widget _contentLoading() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            LoadingBouncingLine.circle(backgroundColor: Colors.deepOrange),
            Text(strContent,
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
