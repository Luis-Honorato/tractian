import 'package:flutter/material.dart';
import 'package:tractian/theme/theme_colors.dart';

class WarningWidget extends StatelessWidget {
  final bool showWarning;
  const WarningWidget({
    super.key,
    required this.showWarning,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: showWarning,
      child: Container(
        decoration: BoxDecoration(
          color: ThemeColors.red,
          borderRadius: BorderRadius.circular(12),
        ),
        width: 8,
        height: 8,
      ),
    );
  }
}
