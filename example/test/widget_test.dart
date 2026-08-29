import 'package:flutter_test/flutter_test.dart';
import 'package:scroll_wheel_date_picker_example/main.dart' show App;

void main() {
  testWidgets('App renders the example screen', (tester) async {
    await tester.pumpWidget(const App());

    expect(find.byType(App), findsOneWidget);
  });
}
