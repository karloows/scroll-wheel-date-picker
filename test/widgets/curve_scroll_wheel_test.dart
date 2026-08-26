import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scroll_wheel_date_picker/src/widgets/curve_scroll_wheel.dart';

Widget _harness({
  required List<String> items,
  required int selectedIndex,
  int? startOffset,
  int? lastOffset,
  required ValueChanged<int> onSelectedItemChanged,
}) {
  return MaterialApp(
    home: Scaffold(
      body: SizedBox(
        height: 300,
        child: CurveScrollWheel(
          items: items,
          selectedIndex: selectedIndex,
          looping: false,
          diameterRatio: 2.0,
          itemExtent: 30,
          overAndUnderCenterOpacity: 0.5,
          textStyle: null,
          listenAfterAnimation: true,
          startOffset: startOffset,
          lastOffset: lastOffset,
          onSelectedItemChanged: onSelectedItemChanged,
        ),
      ),
    ),
  );
}

void main() {
  final items = List.generate(10, (i) => '$i');

  testWidgets(
      'landing on a lastOffset-protected item snaps backward into the valid range, not deeper into it',
      (tester) async {
    int? reportedIndex;

    // lastOffset: 7 protects indices 7, 8, 9. Landing mid-zone (8) used to
    // push further into the restricted zone (towards 9) instead of escaping
    // it — see the identical fix in flat_scroll_wheel.dart.
    await tester.pumpWidget(_harness(
      items: items,
      selectedIndex: 8,
      lastOffset: 7,
      onSelectedItemChanged: (i) => reportedIndex = i,
    ));

    await tester.fling(find.byType(CurveScrollWheel), const Offset(0, 0.01), 1);
    await tester.pumpAndSettle();
    await tester.pump(const Duration(milliseconds: 800));
    await tester.pumpAndSettle();
    await tester.pump(const Duration(milliseconds: 800));

    expect(reportedIndex, 6);
  });
}
