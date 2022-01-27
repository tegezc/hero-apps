import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hero/util/component/label/component_label.dart';

class WidgetTimer extends StatefulWidget {
  const WidgetTimer(
      {Key? key, required this.onTimemerFinish, required this.isActive})
      : super(key: key);
  final Function onTimemerFinish;
  final bool isActive;

  @override
  _WidgetTimerState createState() => _WidgetTimerState();
}

class _WidgetTimerState extends State<WidgetTimer> {
  Timer? _timer;
  int _counter = 30;

  int _counterBuild = 0;
  @override
  void initState() {
    super.initState();
  }

  void _startTimer() {
    _counter = 30;
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter > 0) {
          _counter--;
        } else {
          _timer!.cancel();
          widget.onTimemerFinish();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_counterBuild == 0) {
      _startTimer();
      _counterBuild++;
    }
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, bottom: 16),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              LabelApp.size2('$_counter'),
              const SizedBox(
                height: 8,
              ),
              LabelAppMiring.size3(
                'Setelah 30 detik, video akan berhenti secara otomatis.',
                color: Colors.red[900],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
