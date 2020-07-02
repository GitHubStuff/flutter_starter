import 'package:date_time_intervals/date_time_intervals.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/foundation.dart';

class TimeEvent {
  final String title;
  final String startTime;
  final String endTime;
  final List<dynamic> elements;
  const TimeEvent({
    @required this.title,
    @required this.startTime,
    @required this.endTime,
    @required this.elements,
  });

  TimeEvent.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        startTime = json['startTime'],
        endTime = json['endTime'],
        elements = json['elements'];

  bool get isBounded => (startDateTime != null && endDateTime != null);

  DateTime get startDateTime {
    try {
      return DateTime.parse(startTime);
    } catch (err) {
      return null;
    }
  }

  DateTime get endDateTime {
    try {
      return DateTime.parse(endTime);
    } catch (err) {
      return null;
    }
  }

  Set<CalendarItem> calendarItemSet() {
    Set<CalendarItem> results = {};
    for (String item in elements) {
      CalendarItem.values.forEach((element) {
        if (EnumToString.parse(element) == item) {
          results.add(element);
        }
      });
    }
    return results;
  }
}
