import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:elapser/json/time_event.dart';
import 'package:elapser/widget/event_widget.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:network_api/url_type_api.dart';

part 'initial_event.dart';
part 'initial_state.dart';

class InitialBloc extends Bloc<InitialEvent, InitialState> {
  @override
  InitialState get initialState => StartingState();

  @override
  Stream<InitialState> mapEventToState(InitialEvent event) async* {
    if (event is ShowSampleWidgetEvent) {
      yield* _firstWidget();
    }
  }

  Stream<InitialState> _firstWidget() async* {
    final widget1 = await _eventWidget('data/flip.json');
    final widget2 = await _eventWidget('data/birth.json');
    final widget3 = await _eventWidget('data/rebuilding.json');
    final widget4 = await _eventWidget('data/seattle.json');

    yield ShowSampleEventState([
      widget1,
      widget2,
      widget3,
      widget4,
    ]);
  }

  Future<EventWidget> _eventWidget(String path) async {
    final url = UrlTypeApi();
    final json = await url.getJson(url: path);
    final TimeEvent event = TimeEvent.fromJson(json);
    return EventWidget(timeEvent: event);
  }
}
