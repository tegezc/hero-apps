import 'package:flutter/material.dart';
import 'package:hero/util/component/label/component_label.dart';

class HoreComboBox<T> extends StatefulWidget {
  final List<T>? lcombo;
  final Function(dynamic) onChanged;
  final T? currentValue;
  final String hint;
  const HoreComboBox(
      {Key? key,
      required this.lcombo,
      required this.onChanged,
      required this.currentValue,
      required this.hint})
      : super(key: key);

  @override
  State<HoreComboBox> createState() => _HoreComboBoxState<T>();
}

class _HoreComboBoxState<T> extends State<HoreComboBox> {
  T? _currentValue;
  @override
  void initState() {
    if (widget.lcombo != null) {
      if (widget.lcombo!.isNotEmpty) {
        _currentValue = widget.currentValue;
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: DropdownButton<T>(
        items: widget.lcombo != null
            ? widget.lcombo!
                .map((o) => DropdownMenuItem<T>(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          o.toString(),
                          style: const TextStyle(
                              color: Colors.black, fontSize: 14),
                        ),
                      ),
                      value: o,
                    ))
                .toList()
            : null,
        onChanged: (value) {
          setState(() {
            _currentValue = value;
          });
          printer(value!);
          // widget.onChanged(value);
        },
        value: _currentValue,
        isExpanded: false,
        hint: LabelBlack.size2(widget.hint),
      ),
    );
  }

  void printer(T value) {
    widget.onChanged(value);
  }
}
