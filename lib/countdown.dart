import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CountdownWidget extends StatefulWidget {
  const CountdownWidget({Key? key}) : super(key: key);

  @override
  _CountdownWidgetState createState() => _CountdownWidgetState();
}

class _CountdownWidgetState extends State<CountdownWidget> {
  Timer? _timer;
  DateTime? _target;
  Duration _duration = new Duration();

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

  void _startTimer() {
    const updateRate = const Duration(seconds: 1);
    _timer = new Timer.periodic(
        updateRate,
        (Timer timer) => setState(() {
              _duration = _durationToTarget;
            }));
  }

  TimeOfDay? get _targetTimeOfDay =>
      _target == null ? null : TimeOfDay.fromDateTime(_target!);

  Duration get _durationToTarget =>
      _target == null ? Duration() : _target!.difference(DateTime.now());

  Future<void> _setTargetPressed() async {
    final date = await showDatePicker(
        context: context,
        initialDate: _target ?? DateTime.now(),
        locale: const Locale("fi", ""),
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));
    if (date != null) {
      final time = await showTimePicker(
          context: context, initialTime: _targetTimeOfDay ?? TimeOfDay.now());
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
    if (_timer == null || !(_timer!.isActive)) {
      _startTimer();
    }
  }

  String padNumber(int number) {
    return number.toString().padLeft(2, "0");
  }

  String _formatTarget() {
    if (_target == null) {
      return "";
    }
    return DateFormat("yyyy-MM-dd HH:mm").format(_target!);
  }

  String formatDuration() {
    final duration = _duration;
    final days = duration.inDays;
    final hours = duration.inHours % 24;
    final minutes = duration.inMinutes % 60;
    final seconds = duration.inSeconds % 60;
    final output =
        '${days.toString()} d, ${padNumber(hours)}:${padNumber(minutes)}:${padNumber(seconds)}';
    return output;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Counting down to:\n${_formatTarget()}",
            textAlign: TextAlign.center,
          ),
          Text(
            "${formatDuration()}",
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
