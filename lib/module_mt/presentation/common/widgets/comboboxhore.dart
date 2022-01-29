import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:hero/util/component/label/component_label.dart';

class HoreComboBox extends StatefulWidget {
  final List<String> lcombo;
  final Function(String) onChange;
  final String currentValue;
  final String hint;
  const HoreComboBox(
      {Key? key,
      required this.lcombo,
      required this.onChange,
      required this.currentValue,
      required this.hint})
      : super(key: key);

  @override
  State<HoreComboBox> createState() => _HoreComboBoxState();
}

class _HoreComboBoxState extends State<HoreComboBox> {
  late String _currentValue;
  @override
  void initState() {
    super.initState();
    _currentValue = widget.currentValue;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: DropdownButton(
        items: widget.lcombo
            .map((value) => DropdownMenuItem(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: value == _currentValue
                        ? Text(
                            value,
                            style: const TextStyle(
                                color: Colors.red, fontSize: 14),
                          )
                        : Text(
                            value,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 14),
                          ),
                  ),
                  value: value,
                ))
            .toList(),
        onChanged: (dynamic value) {
          setState(() {
            _currentValue = value;
          });
          widget.onChange(value);
        },
        value: _currentValue,
        isExpanded: false,
        hint: LabelBlack.size2(widget.hint),
      ),
    );
  }
}
