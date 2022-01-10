import 'package:flutter/material.dart';

class WidgeSuccessSubmit extends StatelessWidget {
  const WidgeSuccessSubmit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.transparent,
      child: Row(
        children: [
          const Spacer(),
          _content(),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _content() {
    return Container(
      //color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: const [
            Icon(
              Icons.check_circle,
              color: Colors.green,
            ),
            Text("Sudah berhasil di submit"),
          ],
        ),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
          border: Border.all(color: Colors.green)),
    );
  }
}
