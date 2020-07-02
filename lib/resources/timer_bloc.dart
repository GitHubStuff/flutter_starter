import 'dart:async';

import 'package:elapser/bloc_providers/bloc/initial_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class TimerBloc {
  Timer _timer;

  void start() {
    final initialBloc = Modular.get<InitialBloc>();
    if (_timer != null) _timer.cancel();
    _timer = Timer.periodic(Duration(milliseconds: 900), (timer) {
      initialBloc.add(ShowSampleWidgetEvent());
    });
  }

  void stop() {
    if (_timer != null) _timer.cancel();
    _timer = null;
  }
}
