import 'package:flutter/material.dart';
import 'package:hero/module_mt/presentation/tandem_selling/common/widget_textfield_withlabel.dart';

class PageAvailability extends StatefulWidget {
  const PageAvailability({Key? key}) : super(key: key);

  @override
  _PageAvailabilityState createState() => _PageAvailabilityState();
}

class _PageAvailabilityState extends State<PageAvailability> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    double widthLabel = 80;
    double widthTextField = s.width - 110;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 4.0),
          child: TextFieldNumberOnlyWithLabel(
              widthLabel: widthLabel,
              widthTextField: widthTextField,
              controller: _controller,
              label: 'Telkomsel'),
        ),
      ],
    );
  }
}
