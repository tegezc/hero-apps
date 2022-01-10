import 'package:flutter/material.dart';

class WidgeSuccessSubmit extends StatelessWidget {
  const WidgeSuccessSubmit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        children: [
          Icon(
            Icons.check_circle,
            color: Colors.green,
          ),
          Text("Sudah berhasil di submit"),
        ],
      ),
    );
  }
}
