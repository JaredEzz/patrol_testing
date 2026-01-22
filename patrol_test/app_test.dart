import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:patrol_testing/main.dart' as app;

void main() {
    final config = PlatformAutomatorConfig(
        web: const WebAutomatorConfig(),
      );

  // 2. Initialize with the explicit config
  PatrolBinding.ensureInitialized(PlatformAutomator(config: config));


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
    'FAIL: incorrect counter value expectation',
    ($) async {
      await $.pumpWidgetAndSettle(const app.MyApp());

      await $.tap(find.byIcon(Icons.add));
      await $.pumpAndSettle();

      // Intentional failure
      expect($('5'), findsOneWidget);
    },
  );
}
