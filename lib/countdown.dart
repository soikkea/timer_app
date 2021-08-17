import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CountdownWidget extends StatefulWidget {
  const CountdownWidget({Key? key}) : super(key: key);

  @override
  _CountdownWidgetState createState() => _CountdownWidgetState();
}

class _CountdownWidgetState extends State<CountdownWidget> {
  Timer? _timer;
  DateTime? _target;

  @override
  void initState() {
    if (_target == null) {
      _target = DateTime.now();
    }
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String get _timeToTarget => _target?.toIso8601String() ?? "";

  Future<void> _setTargetPressed() async {
    final date = await showDatePicker(
        context: context,
        initialDate: _target ?? DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));
    if (date != null) {
      final time =
          await showTimePicker(context: context, initialTime: TimeOfDay.now());
      if (time != null) {
        _setTarget(date, time);
      }
    }
  }

  void _setTarget(DateTime date, TimeOfDay time) {
    final dateTime =
        new DateTime(date.year, date.month, date.day, time.hour, time.minute);
    setState(() {
      _target = dateTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _timeToTarget,
            style:
                DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0),
          ),
          ElevatedButton(
              onPressed: _setTargetPressed, child: Text("Set target"))
        ],
      ),
    ));
  }
}
