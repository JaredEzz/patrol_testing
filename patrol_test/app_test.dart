import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:patrol_testing/main.dart'; // Ensure this matches your project name

void main() {
  PatrolBinding.ensureInitialized();
  patrolTest(
    'counter increments correctly when tapped',
    (PatrolIntegrationTester $) async {
      await $.pumpWidgetAndSettle(const MyApp());

      // Check initial state
      expect($('0'), findsOneWidget);
      expect($('1'), findsNothing);

      // Tap the FAB (Floating Action Button)
      // Patrol can find by Icon, Tooltip, or Type
      await $.tap(find.byIcon(Icons.add));
      await $.pumpAndSettle();

      // Verify increment
      expect($('1'), findsOneWidget);
      expect($('0'), findsNothing);
    },
  );

  patrolTest(
    'multiple taps increment counter to 3',
    (PatrolIntegrationTester $) async {
      await $.pumpWidgetAndSettle(const MyApp());

      // Perform multiple taps
      await $.tap(find.byType(FloatingActionButton));
      await $.tap(find.byType(FloatingActionButton));
      await $.tap(find.byType(FloatingActionButton));
      await $.pumpAndSettle();

      expect($('3'), findsOneWidget);
    },
  );

  // --- FAILING TESTS FOR EVALUATION ---

  patrolTest(
    'FAIL: incorrect counter value expectation',
    (PatrolIntegrationTester $) async {
      await $.pumpWidgetAndSettle(const MyApp());

      await $.tap(find.byIcon(Icons.add));
      await $.pumpAndSettle();

      // We expect 5, but the app will actually show 1.
      // This will trigger a standard TestFailure.
      expect($('5'), findsOneWidget);
    },
  );
}