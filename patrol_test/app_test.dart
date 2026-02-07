import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:patrol_testing/main.dart' as app;

void main() {
  patrolTest(
    'counter increments correctly when tapped',
    ($) async {
      await $.pumpWidgetAndSettle(const app.MyApp());

      expect($('0'), findsOneWidget);
      expect($('1'), findsNothing);

      await $.tap(find.byIcon(Icons.add));
      await $.pumpAndSettle();

      expect($('1'), findsOneWidget);
      expect($('0'), findsNothing);
    },
  );

  patrolTest(
    'multiple taps increment counter to 3',
    ($) async {
      await $.pumpWidgetAndSettle(const app.MyApp());

      await $.tap(find.byType(FloatingActionButton));
      await $.tap(find.byType(FloatingActionButton));
      await $.tap(find.byType(FloatingActionButton));
      await $.pumpAndSettle();

      expect($('3'), findsOneWidget);
    },
  );

  patrolTest(
    'counter starts at zero',
    ($) async {
      await $.pumpWidgetAndSettle(const app.MyApp());

      // Verify initial state
      expect($('0'), findsOneWidget);
      expect($(FloatingActionButton), findsOneWidget);
    },
  );
}
