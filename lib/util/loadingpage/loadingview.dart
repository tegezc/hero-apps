import 'package:flutter/material.dart';
import 'package:hero/util/component/widget/component_widget.dart';
import 'package:loading_animations/loading_animations.dart';

class LoadingNunggu extends StatelessWidget {
  final String strContent;

  const LoadingNunggu(this.strContent, {Key? key}) : super(key: key);

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
  const BelumAdaData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan[600],
          title: const Text(''),
        ),
        body: const Center(child: Text('Belum ada data ')));
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan[600],
          title: const Text(''),
        ),
        body: const Center(child: Text('Terjadi Kesalahan')));
  }
}

class LoadingTransparan extends StatelessWidget {
  final String strContent;

  const LoadingTransparan(this.strContent, {Key? key}) : super(key: key);

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
            SizedBox(
              width: mediaQueryData.size.width,
              height: mediaQueryData.size.height,
              child: Center(
                  child: Column(
                children: [
                  const SizedBox(
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
                style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
