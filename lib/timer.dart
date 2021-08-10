import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimerWidget extends StatefulWidget {
  const TimerWidget({Key? key}) : super(key: key);

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  Timer? _timer;
  bool _running = false;
  Stopwatch _stopwatch = new Stopwatch();
  Duration get elapsedTime => _stopwatch.elapsed;

  void startTimer() {
    _stopwatch.start();
    const updateRate = const Duration(milliseconds: 50);
    _timer = new Timer.periodic(updateRate, (Timer timer) => setState(() {}));
  }

  void toggleTimer() {
    setState(() {
      _running = !_running;
    });
    if (_running && _timer == null) {
      startTimer();
    } else if (!_running && _timer != null) {
      _timer?.cancel();
      _timer = null;
      if (_stopwatch.isRunning) {
        _stopwatch.stop();
      }
    }
  }

  void resetValue() {
    _stopwatch.reset();
    setState(() {});
  }

  String _formatValue() {
    return elapsedTime.toString().substring(0, 10);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "${_formatValue()}",
            style:
                DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0),
          ),
          ElevatedButton(
              onPressed: () {
                toggleTimer();
              },
              child: Text(_running ? "stop" : "start")),
          ElevatedButton(onPressed: resetValue, child: Text("Reset"))
        ],
      ),
    );
  }
}
