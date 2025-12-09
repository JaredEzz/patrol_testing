import 'package:patrol/patrol.dart';
import 'package:patrol_testing/main.dart';

void main() {
  patrolTest(
    'start app',
    (PatrolIntegrationTester $) async {
      await $.pumpWidgetAndSettle(MyApp());
    },
  );
}
