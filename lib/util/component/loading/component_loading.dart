import 'package:flutter/material.dart';

class LoadComponent1 extends StatelessWidget {
  final double height;
  final double width;

  LoadComponent1(this.height, this.width);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: this.height,
        width: this.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.grey[200],
        ));
  }
}

class LoadComponentFractional extends StatelessWidget {
  final double heightFactor;
  final double widthFactor;

  LoadComponentFractional(this.heightFactor, this.widthFactor);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FractionallySizedBox(
          heightFactor: this.heightFactor,
          widthFactor: this.widthFactor,
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

  LoadComponentFractionalWidth(this.height, this.widthFactor);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: this.height,
        child: FractionallySizedBox(
          widthFactor: this.widthFactor,
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

  LoadComponentFractionalHeight(this.heightFactor, this.width);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: this.width,
        child: FractionallySizedBox(
          heightFactor: this.heightFactor,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.grey[200],
        ));
  }
}

class LoadingTextFieldLogin extends StatelessWidget {
  final double widthFactor;

  LoadingTextFieldLogin(this.widthFactor);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label(),
        SizedBox(
          height: 5,
        ),
        _entryField(),
      ],
    );
  }

  Widget _label() {
    return LoadComponent1(20, 100);
  }

  Widget _entryField() {
    return LoadComponentFractionalWidth(50, this.widthFactor);
  }
}
