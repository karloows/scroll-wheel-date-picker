import 'package:flutter/cupertino.dart' show CupertinoContextMenu;
import 'package:flutter/material.dart'
    show
        StatelessWidget,
        Widget,
        BuildContext,
        Container,
        BoxDecoration,
        Colors,
        BorderRadius,
        Color;

import '../../constants/theme_constants.dart' show defaultOpacity;

class HightlightOverlay extends StatelessWidget {
  /// Creates a rounded rectangle background with the default [CupertinoContextMenu.kOpenBorderRadius] radius.
  const HightlightOverlay({
    super.key,
    required this.height,
    this.color,
  });

  /// Actual height of the [HightlightOverlay].
  final double height;

  /// Background color.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: color ?? Colors.grey.withValues(alpha: defaultOpacity),
        borderRadius:
            BorderRadius.circular(CupertinoContextMenu.kOpenBorderRadius),
      ),
    );
  }
}
