import 'package:flutter/material.dart';
import 'package:tractian/theme/theme_colors.dart';

class TractianTheme {
  static ThemeData get theme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: ThemeColors.bluePrimary),

      appBarTheme: const AppBarTheme(
        centerTitle: true,
        backgroundColor: ThemeColors.blueBackground,
        elevation: 0,
      ),

      /// TextThemes
      textTheme: const TextTheme(
        /// Used in companiy widget to display company name
        bodyLarge: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 18,
          color: ThemeColors.white,
        ),

        /// Used in Nodes names
        bodyMedium: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          color: ThemeColors.fontColorPrimary,
        ),

        /// Used in buttons
        bodySmall: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: ThemeColors.fontColorButton,
        ),
      ),
    );
  }
}
