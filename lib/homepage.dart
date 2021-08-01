import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'timer.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(child: TimerWidget()));
  }
}
