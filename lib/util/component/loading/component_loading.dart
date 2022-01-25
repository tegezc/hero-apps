import 'package:flutter/material.dart';

class LoadComponent1 extends StatelessWidget {
  final double height;
  final double width;

  const LoadComponent1(this.height, this.width, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.grey[200],
        ));
  }
}

class LoadComponentFractional extends StatelessWidget {
  final double heightFactor;
  final double widthFactor;

  const LoadComponentFractional(this.heightFactor, this.widthFactor, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FractionallySizedBox(
          heightFactor: heightFactor,
          widthFactor: widthFactor,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.grey[200],
        ));
  }
}

class LoadComponentFractionalWidth extends StatelessWidget {
  final double height;
  final double widthFactor;

  const LoadComponentFractionalWidth(this.height, this.widthFactor, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        child: FractionallySizedBox(
          widthFactor: widthFactor,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.grey[200],
        ));
  }
}

class LoadComponentFractionalHeight extends StatelessWidget {
  final double heightFactor;
  final double width;

  const LoadComponentFractionalHeight(this.heightFactor, this.width, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        child: FractionallySizedBox(
          heightFactor: heightFactor,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.grey[200],
        ));
  }
}

class LoadingTextFieldLogin extends StatelessWidget {
  final double widthFactor;

  const LoadingTextFieldLogin(this.widthFactor, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label(),
        const SizedBox(
          height: 5,
        ),
        _entryField(),
      ],
    );
  }

  Widget _label() {
    return const LoadComponent1(20, 100);
  }

  Widget _entryField() {
    return LoadComponentFractionalWidth(50, widthFactor);
  }
}
