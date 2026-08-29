import 'package:flutter/material.dart'
    show StatelessWidget, Widget, BuildContext, MaterialApp, ThemeData, runApp;

import 'scroll_wheel_date_picker.dart' show ScrollWheelDatePicker;

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scroll Wheel Date Picker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const ScrollWheelDatePicker(),
    );
  }
}
