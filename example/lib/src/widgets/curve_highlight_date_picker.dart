import 'package:scroll_wheel_date_picker/scroll_wheel_date_picker.dart'
    show
        ScrollWheelDatePicker,
        CurveDatePickerTheme,
        ScrollWheelDatePickerOverlay,
        MonthFormat;
import 'package:flutter/material.dart'
    show
        StatelessWidget,
        Widget,
        BuildContext,
        Scaffold,
        Colors,
        AppBar,
        Text,
        TextStyle,
        FontWeight,
        Center,
        Padding,
        EdgeInsets;

class CurveHighlightDatePicker extends StatelessWidget {
  const CurveHighlightDatePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text(
          "Curve Highlight Overlay",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ScrollWheelDatePicker(
            theme: CurveDatePickerTheme(
              wheelPickerHeight: 200.0,
              overlay: ScrollWheelDatePickerOverlay.highlight,
              monthFormat: MonthFormat.threeLetters,
            ),
          ),
        ),
      ),
    );
  }
}
