import 'package:flutter/material.dart';

class ContainerRounded extends StatelessWidget {
  final Widget child;
  final double radius;
  final Color borderColor;
  final double? height;
  final double? width;

  ContainerRounded(
      {required this.child,
      required this.radius,
      this.borderColor = Colors.transparent,
      this.height,
      this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.height,
      width: this.width,
      child: child,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(this.radius),
          color: Colors.white,
          border: Border.all(color: this.borderColor)),
    );
  }
}

class CustomScaffold extends StatelessWidget {
  final Widget body;
  final String title;
  final bool automaticallyImplyLeading;
  CustomScaffold(
      {required this.body,
      required this.title,
      this.automaticallyImplyLeading = true});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: this.automaticallyImplyLeading,
        backgroundColor: Colors.red[600],
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Text(
          this.title,
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [],
      ),
      body: this.body,
    );
  }
}

class CustomScaffoldWithAction extends StatelessWidget {
  final Widget body;
  final String title;
  final Widget action;
  final bool automaticallyImplyLeading;
  CustomScaffoldWithAction(
      {required this.body,
      required this.title,
      required this.action,
      this.automaticallyImplyLeading = true});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: this.automaticallyImplyLeading,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          this.title,
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          this.action,
        ],
      ),
      body: this.body,
    );
  }
}
