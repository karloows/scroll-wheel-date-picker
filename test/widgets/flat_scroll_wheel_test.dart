import 'package:flutter/material.dart'
    show MaterialApp, Scaffold, SizedBox, ValueChanged, Offset, Widget;
import 'package:flutter/widgets.dart'
    show NotificationListener, ScrollNotification;
import 'package:flutter_test/flutter_test.dart'
    show testWidgets, expect, find, lessThan;
import 'package:scroll_wheel_date_picker/src/widgets/flat_scroll_wheel.dart'
    show FlatScrollWheel;

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
        child: FlatScrollWheel(
          items: items,
          selectedIndex: selectedIndex,
          looping: false,
          itemExtent: 30,
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
      'landing on a startOffset-protected item snaps forward to the first valid item',
      (tester) async {
    int? reportedIndex;

    // startOffset: 3 protects indices 0, 1, 2. Land in the middle of that
    // zone via a negligible fling that settles back on the same item.
    await tester.pumpWidget(_harness(
      items: items,
      selectedIndex: 1,
      startOffset: 3,
      onSelectedItemChanged: (i) => reportedIndex = i,
    ));

    await tester.fling(find.byType(FlatScrollWheel), const Offset(0, -0.01), 1);
    await tester.pumpAndSettle();
    // _handleOffset waits 800ms before correcting.
    await tester.pump(const Duration(milliseconds: 800));
    await tester.pumpAndSettle();
    // The corrective scroll's own settle re-arms a fresh 800ms no-op delay;
    // flush it too so no timer is left pending at teardown.
    await tester.pump(const Duration(milliseconds: 800));

    expect(reportedIndex, 3);
  });

  testWidgets(
      'landing on a lastOffset-protected item snaps backward to the last valid item',
      (tester) async {
    int? reportedIndex;

    // lastOffset: 7 protects indices 7, 8, 9. Land in the middle of that
    // zone via a negligible fling that settles back on the same item.
    await tester.pumpWidget(_harness(
      items: items,
      selectedIndex: 8,
      lastOffset: 7,
      onSelectedItemChanged: (i) => reportedIndex = i,
    ));

    await tester.fling(find.byType(FlatScrollWheel), const Offset(0, 0.01), 1);
    await tester.pumpAndSettle();
    await tester.pump(const Duration(milliseconds: 800));
    await tester.pumpAndSettle();
    await tester.pump(const Duration(milliseconds: 800));

    expect(reportedIndex, 6);
  });

  testWidgets(
      'startOffset changed via rebuild (didUpdateWidget) still snaps correctly',
      (tester) async {
    int? reportedIndex;

    await tester.pumpWidget(_harness(
      items: items,
      selectedIndex: 1,
      startOffset: 2,
      onSelectedItemChanged: (i) => reportedIndex = i,
    ));
    await tester.pump();

    // Simulate the parent widget updating startOffset in response to a
    // changed start date — exercises didUpdateWidget's listener rewiring,
    // the exact code path touched by the tear-off refactor.
    await tester.pumpWidget(_harness(
      items: items,
      selectedIndex: 1,
      startOffset: 4,
      onSelectedItemChanged: (i) => reportedIndex = i,
    ));

    await tester.fling(find.byType(FlatScrollWheel), const Offset(0, -0.01), 1);
    await tester.pumpAndSettle();
    await tester.pump(const Duration(milliseconds: 800));
    await tester.pumpAndSettle();
    await tester.pump(const Duration(milliseconds: 800));

    // Index 1 is only protected under the *new* startOffset (4), so a
    // correct rewiring must snap it forward to 4.
    expect(reportedIndex, 4);
  });

  testWidgets(
      'a wheel scrolled several loops deep corrects locally, not by jumping back to the absolute item index',
      (tester) async {
    int? reportedIndex;
    final pixelSamples = <double>[];

    // 38 = 3 full loops + logical index 8, deep inside the lastOffset-7
    // protected zone ([7, 8, 9]). The correction must nudge from ~38, not
    // jump back to the unlooped absolute index 6 (a ~960px jump vs ~60px).
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: SizedBox(
          height: 300,
          child: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              pixelSamples.add(notification.metrics.pixels);
              return false;
            },
            child: FlatScrollWheel(
              items: items,
              selectedIndex: 38,
              looping: true,
              itemExtent: 30,
              listenAfterAnimation: true,
              lastOffset: 7,
              onSelectedItemChanged: (i) => reportedIndex = i,
            ),
          ),
        ),
      ),
    ));

    await tester.fling(find.byType(FlatScrollWheel), const Offset(0, 0.01), 1);
    await tester.pumpAndSettle();
    // Discard samples from the settle-back above; only the corrective
    // animation below is under test.
    pixelSamples.clear();
    await tester.pump(const Duration(milliseconds: 800));
    await tester.pumpAndSettle();
    await tester.pump(const Duration(milliseconds: 800));

    // The reported (looped) index alone can't tell a local nudge apart from
    // a multi-loop jump — both normalize to the same value — so assert on
    // the raw pixel distance actually travelled instead.
    expect(reportedIndex, 6);
    final spread = pixelSamples.reduce((a, b) => a > b ? a : b) -
        pixelSamples.reduce((a, b) => a < b ? a : b);
    expect(spread, lessThan(10 * 30));
  });
}
