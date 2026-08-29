import 'package:flutter/material.dart'
    show
        StatelessWidget,
        Widget,
        BuildContext,
        Container,
        EdgeInsets,
        Border,
        BorderSide,
        Colors,
        BoxDecoration,
        Color;

import '../../constants/theme_constants.dart'
    show defaultModeMargin, defaultModeBorderThickness;

class LineOverlay extends StatelessWidget {
  /// Creates a horizontal parallel lines.
  const LineOverlay({
    super.key,
    required this.height,
    this.color,
  });

  /// Gap between the lines of [LineOverlay].
  final double height;

  /// Lines color.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: defaultModeMargin),
      height: height,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: color ?? Colors.white,
            width: defaultModeBorderThickness,
          ),
          bottom: BorderSide(
            color: color ?? Colors.white,
            width: defaultModeBorderThickness,
          ),
        ),
      ),
    );
  }
}
