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

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
        oneSec,
        (Timer timer) => setState(() {
              if (_running) {
                _value = _value + 1;
              }
            }));
  }

  void toggleTimer() {
    _running = !_running;
    if (_running && _timer == null) {
      startTimer();
    } else if (!_running && _timer != null) {
      _timer?.cancel();
      _timer = null;
    }
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
              child: Text("start/stop"))
        ],
      ),
    );
  }
}
