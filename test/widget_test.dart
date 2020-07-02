// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:date_time_intervals/date_time_intervals.dart';
import 'package:elapser/json/time_event.dart';
import 'package:elapser/resources/elapsed_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_api/url_type_api.dart';

void main() {
  testWidgets('Calendar Items parse', (WidgetTester tester) async {
    final url = UrlTypeApi();
    final json = await url.getJson(url: 'data/rebuilding.json');
    debugPrint('JSON ${json.toString()}');
    final TimeEvent event = TimeEvent.fromJson(json);
    Set<CalendarItem> set = event.calendarItemSet();
    final start = event.startDateTime;
    final end = event.endDateTime;
    debugPrint('$start $end');
    final displayText = elapsedString(forEvent: event);
    debugPrint('$displayText');
  });

  testWidgets('Birthday', (WidgetTester tester) async {
    final url = UrlTypeApi();
    final json = await url.getJson(url: 'data/birth.json');
    debugPrint('Birthday ${json.toString()}');
    final TimeEvent event = TimeEvent.fromJson(json);
    Set<CalendarItem> set = event.calendarItemSet();
    final start = event.startDateTime;
    final end = event.endDateTime;
    debugPrint('$start $end');
    final displayText = elapsedString(forEvent: event);
    debugPrint('$displayText');
  });
  testWidgets('Seattle', (WidgetTester tester) async {
    final url = UrlTypeApi();
    final json = await url.getJson(url: 'data/seattle.json');
    debugPrint('Seattle ${json.toString()}');
    final TimeEvent event = TimeEvent.fromJson(json);
    final start = event.startDateTime;
    final end = event.endDateTime;
    debugPrint('$start $end');
    final displayText = elapsedString(forEvent: event);
    debugPrint('$displayText');
  });

  testWidgets('Flipper', (WidgetTester tester) async {
    final url = UrlTypeApi();
    final json = await url.getJson(url: 'data/flip.json');
    debugPrint('Flip ${json.toString()}');
    final TimeEvent event = TimeEvent.fromJson(json);
    final start = event.startDateTime;
    final end = event.endDateTime;
    debugPrint('$start $end');
    final displayText = elapsedNonZeroString(forEvent: event, directions: ['until', 'between', 'since']);
    debugPrint('$displayText');
  });
}
