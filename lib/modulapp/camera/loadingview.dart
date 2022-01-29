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
  final String message;
  const BelumAdaData({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan[600],
          title: const Text('Hore'),
        ),
        body: Center(child: Text(message)));
  }
}

class ErrorPage extends StatelessWidget {
  final String message;
  const ErrorPage({Key? key, required this.message}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan[600],
          title: const Text('Error page'),
        ),
        body: Center(child: Text(message)));
  }
}
