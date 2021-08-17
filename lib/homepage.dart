import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timer_app/countdown.dart';

import 'timer.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              title: Text(title),
              bottom: const TabBar(tabs: [
                Tab(
                  text: "Timer",
                ),
                Tab(
                  text: "Countdown",
                )
              ]),
            ),
            body: TabBarView(children: [_timerTab(), _countdownTab()])));
  }

  Center _timerTab() => Center(child: TimerWidget());

  Widget _countdownTab() => Center(
        child: CountdownWidget(),
      );
}
