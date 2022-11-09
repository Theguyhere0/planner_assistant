import 'package:flutter/material.dart';
import './palette.dart';

class CustomTheme {
  static ThemeData theme() {
    return ThemeData.dark().copyWith(
      scaffoldBackgroundColor: Palette.background,
      cardColor: Palette.card,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      disabledColor: Palette.suppressed,
      colorScheme: const ColorScheme.dark(primary: Palette.highlight),
      tooltipTheme: const TooltipThemeData(
        waitDuration: Duration(milliseconds: 350),
        decoration: BoxDecoration(
          color: Palette.focus,
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        textStyle: TextStyle(
          fontFamily: 'Noto Sans',
          color: Palette.primaryText,
        ),
      ),
      dividerColor: Colors.transparent,
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Palette.highlight,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: Palette.primaryText,
          fontSize: 64,
          height: 0.8,
          leadingDistribution: TextLeadingDistribution.even,
          fontFamily: 'M PLUS Rounded 1c',
        ),
        headlineLarge: TextStyle(
          color: Palette.secondaryText,
          fontSize: 32,
          height: 0.8,
          leadingDistribution: TextLeadingDistribution.even,
          fontFamily: 'M PLUS Rounded 1c',
        ),
        headlineSmall: TextStyle(
          color: Palette.suppressed,
          fontSize: 20,
          height: 0.8,
          leadingDistribution: TextLeadingDistribution.even,
          fontFamily: 'M PLUS Rounded 1c',
        ),
        titleLarge: TextStyle(
          fontFamily: 'Noto Sans',
          color: Palette.primaryText,
          fontSize: 20,
        ),
        titleMedium: TextStyle(
          fontFamily: 'Noto Sans',
          color: Palette.primaryText,
        ),
        bodyMedium: TextStyle(
          fontFamily: 'Noto Sans',
          color: Palette.primaryText,
        ),
      ),
    );
  }
}
