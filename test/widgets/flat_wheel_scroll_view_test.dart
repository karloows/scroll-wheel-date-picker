import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scroll_wheel_date_picker/src/widgets/flat_wheel_scroll_view.dart';

Widget _harness({
  required int itemCount,
  required bool looping,
  required FlatScrollController controller,
  ValueChanged<int>? onSelectedItemChanged,
}) {
  return MaterialApp(
    home: Scaffold(
      body: SizedBox(
        height: 300,
        child: FlatWheelScrollView(
          controller: controller,
          itemExtent: 30,
          itemCount: itemCount,
          looping: looping,
          onSelectedItemChanged: onSelectedItemChanged,
          itemBuilder: (context, index) => Text('item-$index'),
        ),
      ),
    ),
  );
}

void main() {
  testWidgets('non-looping view renders exactly itemCount items, no wrap',
      (tester) async {
    final controller = FlatScrollController();
    addTearDown(controller.dispose);

    await tester.pumpWidget(
      _harness(itemCount: 5, looping: false, controller: controller),
    );

    expect(find.text('item-0'), findsOneWidget);
    // Only one sliver (no reversed half) is rendered when not looping, so
    // item indices never go negative and never exceed itemCount - 1.
    expect(find.text('item-4'), findsOneWidget);
  });

  testWidgets(
      'looping jumpToItem past the last index reports the wrapped-around true index',
      (tester) async {
    final controller = FlatScrollController();
    addTearDown(controller.dispose);
    int? reportedIndex;

    await tester.pumpWidget(
      _harness(
        itemCount: 5,
        looping: true,
        controller: controller,
        onSelectedItemChanged: (index) => reportedIndex = index,
      ),
    );

    // 7 is past the last valid index (4) — _getTrueIndex should wrap it via
    // modulo back into range rather than leaving it out of bounds.
    controller.jumpToItem(7);
    await tester.pump();

    expect(reportedIndex, 2);
  });

  testWidgets(
      'looping jumpToItem to a negative index reports the wrapped-around true index',
      (tester) async {
    final controller = FlatScrollController();
    addTearDown(controller.dispose);
    int? reportedIndex;

    await tester.pumpWidget(
      _harness(
        itemCount: 5,
        looping: true,
        controller: controller,
        onSelectedItemChanged: (index) => reportedIndex = index,
      ),
    );

    // Negative indices use a different branch of _getTrueIndex than
    // positive overflow — Dart's `%` on negatives doesn't wrap the way a
    // naive modulo would, which is exactly the case this method exists to fix.
    controller.jumpToItem(-1);
    await tester.pump();

    expect(reportedIndex, 4);
  });

  testWidgets('jumpToItem within range reports that exact index',
      (tester) async {
    final controller = FlatScrollController();
    addTearDown(controller.dispose);
    int? reportedIndex;

    await tester.pumpWidget(
      _harness(
        itemCount: 5,
        looping: true,
        controller: controller,
        onSelectedItemChanged: (index) => reportedIndex = index,
      ),
    );

    controller.jumpToItem(3);
    await tester.pump();

    expect(reportedIndex, 3);
  });

  testWidgets(
      'onSelectedItemChanged is not called when landing back on initialItem',
      (tester) async {
    final controller = FlatScrollController(initialItem: 2);
    addTearDown(controller.dispose);
    int callCount = 0;

    await tester.pumpWidget(
      _harness(
        itemCount: 5,
        looping: true,
        controller: controller,
        onSelectedItemChanged: (_) => callCount++,
      ),
    );

    await tester.pump();

    expect(callCount, 0);
  });
}
