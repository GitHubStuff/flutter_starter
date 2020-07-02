import 'package:date_time_intervals/date_time_intervals.dart';
import 'package:date_time_intervals/source/intervals.dart';
import 'package:elapser/json/time_event.dart';
import 'package:flutter/foundation.dart';
import 'package:tracers/tracers.dart' as Log;

String elapsedString({
  @required TimeEvent forEvent,
  List<String> directions,
}) {
  final startTime = (forEvent.startDateTime ?? DateTime.now()).toLocal();
  final endTime = (forEvent.endDateTime ?? DateTime.now()).toLocal();
  Log.t('START:${startTime.toIso8601String()} END:${endTime.toIso8601String()}');
  final items = DateTimeIntervals(
    setOfCalendarItems: forEvent.calendarItemSet(),
    startEvent: startTime,
    endEvent: endTime,
  );
  String result = '';
  if (items.years != null) {
    final suffix = items.years == 1 ? 'yr' : 'yrs';
    result = '${items.years} $suffix ';
  }
  if (items.months != null) {
    final suffix = items.months == 1 ? 'mth' : 'mths';
    result = '$result${items.months} $suffix ';
  }
  if (items.days != null) {
    final suffix = items.days == 1 ? 'day' : 'days';
    result = '$result${items.days} $suffix ';
  }
  if (items.hours != null) {
    final suffix = items.hours == 1 ? 'hr' : 'hrs';
    result = '$result${items.hours} $suffix ';
  }
  if (items.minutes != null) {
    final suffix = items.minutes == 1 ? 'min' : 'mins';
    result = '$result${items.minutes} $suffix ';
  }
  if (items.seconds != null) {
    final suffix = items.seconds == 1 ? 'sec' : 'secs';
    result = '$result${items.seconds} $suffix';
  }
  if (directions != null && directions.length == 3) {
    final duration = endTime.difference(startTime);
    result = (forEvent.startDateTime != null && forEvent.endDateTime != null)
        ? '$result ${directions[1]}'
        : (duration.isNegative) ? '$result ${directions[0]}' : '$result ${directions[2]}';
  }
  return result;
}

String elapsedNonZeroString({
  @required TimeEvent forEvent,
  List<String> directions,
}) {
  final startTime = (forEvent.startDateTime ?? DateTime.now()).toLocal();
  final endTime = (forEvent.endDateTime ?? DateTime.now()).toLocal();
  Log.t('START:${startTime.toIso8601String()} END:${endTime.toIso8601String()}');
  final items = DateTimeIntervals(
    setOfCalendarItems: forEvent.calendarItemSet(),
    startEvent: startTime,
    endEvent: endTime,
  );
  String result = '';
  bool foundNonZero = false;
  if (items.years != null) {
    foundNonZero = items.years > 0;
    if (foundNonZero) {
      final suffix = items.years == 1 ? 'yr' : 'yrs';
      result = '${items.years} $suffix ';
    }
  }
  if (items.months != null) {
    foundNonZero = foundNonZero || items.months > 0;
    if (foundNonZero) {
      final suffix = items.months == 1 ? 'mth' : 'mths';
      result = '$result${items.months} $suffix ';
    }
  }
  if (items.days != null) {
    foundNonZero = foundNonZero || items.days > 0;
    if (foundNonZero) {
      final suffix = items.days == 1 ? 'day' : 'days';
      result = '$result${items.days} $suffix ';
    }
  }
  if (items.hours != null) {
    foundNonZero = foundNonZero || items.hours > 0;
    if (foundNonZero) {
      final suffix = items.hours == 1 ? 'hr' : 'hrs';
      result = '$result${items.hours} $suffix ';
    }
  }
  if (items.minutes != null) {
    foundNonZero = foundNonZero || items.minutes > 0;
    if (foundNonZero) {
      final suffix = items.minutes == 1 ? 'min' : 'mins';
      result = '$result${items.minutes} $suffix ';
    }
  }
  if (items.seconds != null) {
    foundNonZero = foundNonZero || items.seconds > 0;
    if (foundNonZero) {
      final suffix = items.seconds == 1 ? 'sec' : 'secs';
      result = '$result${items.seconds} $suffix';
    }
  }
  if (directions != null && directions.length == 3) {
    if (forEvent.isBounded) return '$result ${directions[1]}';
    final duration = endTime.difference(startTime);
    result = (duration.isNegative) ? '$result ${directions[0]}' : '$result ${directions[2]}';
  }
  return result;
}

CalendarDirection calendarDirection({@required TimeEvent forEvent}) {
  if (forEvent.isBounded) return CalendarDirection.between;
  final startTime = (forEvent.startDateTime ?? DateTime.now()).toLocal();
  final endTime = (forEvent.endDateTime ?? DateTime.now()).toLocal();
  final duration = endTime.difference(startTime);
  return (duration.isNegative) ? CalendarDirection.untilEnd : CalendarDirection.sinceEnd;
}
