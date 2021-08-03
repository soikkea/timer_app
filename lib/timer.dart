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
  int _value = 0;
  bool _running = false;
  Stopwatch? _stopwatch;

  void startTimer() {
    if (_stopwatch == null) {
      _stopwatch = new Stopwatch();
    }
    _stopwatch!.start();
    const updateRate = const Duration(milliseconds: 500);
    _timer = new Timer.periodic(
        updateRate,
        (Timer timer) => setState(() {
              if (_running) {
                _value = _stopwatch!.elapsedMilliseconds ~/ 1000;
              }
            }));
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
      if (_stopwatch?.isRunning ?? false) {
        _stopwatch!.stop();
      }
    }
  }

  void resetValue() {
    _stopwatch?.reset();
    setState(() {
      _value = 0;
    });
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
          Text("$_value"),
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
