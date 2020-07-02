import 'package:date_time_popover/date_time_picker/common.dart';
import 'package:elapser/bloc_providers/bloc/initial_bloc.dart';
import 'package:elapser/resources/timer_bloc.dart';

import '../modules/initial_module.dart';
import '../resources/app_localizations.dart';
import '../resources/constants.dart' as Constants;

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mode_theme/mode_theme.dart';
import 'package:tracers/tracers.dart' as Log;

class InitialScreen extends ModularStatelessWidget<InitialModule> {
  static TimerBloc _timerBloc = TimerBloc();
  @override
  Widget build(BuildContext context) {
    return _scaffold(context);
  }

  Widget _scaffold(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Constants.modeIcon,
            onPressed: () {
              ModeTheme.of(context).toggleBrightness();
            },
          )
        ],
        title: Text(tr(context, 'Title')), //TODO provide translation
      ),
      body: _InitialWidget(), // body(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {},
        tooltip: 'NoOp',
        child: Icon(Icons.add),
      ),
    );
  }
}

//MARK:
class _InitialWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final initialBloc = Modular.get<InitialBloc>();
    return BlocBuilder(
      bloc: initialBloc,
      builder: (context, InitialState state) {
        if (state is StartingState) {
          initialBloc.add(ShowSampleWidgetEvent());
          InitialScreen._timerBloc.start();
        }
        if (state is ShowSampleEventState) {
          List<Widget> widgets = state.widgets;
          return ListView.builder(
            itemBuilder: (context, position) {
             return widgets[position];
            },
            itemCount: widgets.length,
          );
        }
        Log.t('state ${state.toString()}');
        return Text('HA!');
      },
    );
  }
}
