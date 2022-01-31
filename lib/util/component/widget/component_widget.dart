import 'package:flutter/material.dart';
import 'package:hero/config/configuration_sf.dart';
import 'package:hero/config/config_mt.dart';

class ContainerRounded extends StatelessWidget {
  final Widget child;
  final double radius;
  final Color borderColor;
  final double? height;
  final double? width;

  const ContainerRounded(
      {Key? key,
      required this.child,
      required this.radius,
      this.borderColor = Colors.transparent,
      this.height,
      this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: child,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: Colors.white,
          border: Border.all(color: borderColor)),
    );
  }
}

class CustomScaffold extends StatelessWidget {
  final Widget body;
  final String title;
  final bool automaticallyImplyLeading;
  const CustomScaffold(
      {Key? key,
      required this.body,
      required this.title,
      this.automaticallyImplyLeading = true})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    ConfigurationSf configuration = ConfigurationSf();
    String textTitle = '$title ${configuration.versionApp()}';
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: automaticallyImplyLeading,
        backgroundColor: Colors.red[600],
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Text(
          textTitle,
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: const [],
      ),
      body: body,
    );
  }
}

class CustomScaffoldWithAction extends StatelessWidget {
  final Widget body;
  final String title;
  final Widget action;
  final bool automaticallyImplyLeading;
  const CustomScaffoldWithAction(
      {Key? key,
      required this.body,
      required this.title,
      required this.action,
      this.automaticallyImplyLeading = true})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: automaticallyImplyLeading,
        backgroundColor: Colors.red[600],
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          action,
        ],
      ),
      body: body,
    );
  }
}

class ScaffoldMT extends StatelessWidget {
  final Widget body;
  final String title;
  final bool automaticallyImplyLeading;
  const ScaffoldMT(
      {Key? key,
      required this.body,
      required this.title,
      this.automaticallyImplyLeading = true})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    ConfigurationMT config = ConfigurationMT();
    String text = '$title ${config.versionApp()}';
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: automaticallyImplyLeading,
        backgroundColor: Colors.red[600],
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: const [],
      ),
      body: body,
    );
  }
}
