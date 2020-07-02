import 'package:auto_size_text/auto_size_text.dart';
import 'package:date_time_intervals/date_time_intervals.dart';
import 'package:date_time_popover/flutter_date_time_popover.dart';
import 'package:elapser/json/time_event.dart';
import 'package:elapser/resources/elapsed_text.dart' as Interval;
import 'package:flutter/material.dart';
import 'package:mode_theme/mode_theme.dart';

class EventWidget extends StatelessWidget {
  final TimeEvent timeEvent;
  const EventWidget({this.timeEvent});

  @override
  Widget build(BuildContext context) {
    return (timeEvent.isBounded) ? _card(context, _boundedEvent(context)) : _card(context, _unboundedEvent(context));
  }

  Widget _card(BuildContext context, Widget child) {
    final direction = Interval.calendarDirection(forEvent: timeEvent);
    Color background;
    switch (direction) {
      case CalendarDirection.between:
        background = Colors.grey;
        break;
      case CalendarDirection.sinceEnd:
        background = Color(0xffb5d3e7);
        break;
      case CalendarDirection.untilEnd:
        background = Color(0xffffb9b9);
        break;
    }
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      width: double.maxFinite,
      height: (timeEvent.isBounded) ? 100 : 90,
      child: Card(
        color: background,
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: child,
        ),
      ),
    );
  }

  Widget _unboundedEvent(BuildContext context) {
    final intervalText = Interval.elapsedNonZeroString(
      forEvent: timeEvent,
      directions: ['until', 'between', 'since'],
    );
    final local = timeEvent.startDateTime.toLocal();
    final startText = '${formattedDate(local)} ${formattedTime(local)}';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _text(context, timeEvent.title),
        _text(context, intervalText),
        _text(context, startText),
      ],
    );
  }

  Widget _boundedEvent(BuildContext context) {
    final intervalText = Interval.elapsedNonZeroString(
      forEvent: timeEvent,
      directions: ['until', 'between', 'since'],
    );
    final startText = '${formattedDate(timeEvent.startDateTime)} ${formattedTime(timeEvent.startDateTime)}';
    final endText = '${formattedDate(timeEvent.endDateTime)} ${formattedTime(timeEvent.endDateTime)}';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _text(context, timeEvent.title),
        _text(context, intervalText),
        _text(context, startText),
        _text(context, endText),
      ],
    );
  }

  Widget _text(BuildContext context, String content) {
    final color = ModeColor(light: Colors.black, dark: Colors.black54).color(context);
    return AutoSizeText(
      content,
      maxLines: 1,
      maxFontSize: 42.0,
      minFontSize: 14.0,
      style: TextStyle(color: color),
    );
  }
}
