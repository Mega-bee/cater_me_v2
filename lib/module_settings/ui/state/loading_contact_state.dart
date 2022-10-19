import 'package:cater_me_v2/abstracts/states/state.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoadingContactSate extends States {
  @override
  Widget getUI(BuildContext context) {
    return  SizedBox(
      height: 100,
      child: Center(
          child: LoadingIndicator(
            indicatorType:
            Indicator.ballBeat,
            colors: [Colors.greenAccent.shade400 , Colors.green.shade600],
          )),
    );
  }
}