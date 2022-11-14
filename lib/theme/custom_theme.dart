import 'package:flutter/material.dart';

import 'palette.dart';
import '../utils/constants.dart';

class CustomTheme {
  static ThemeData theme() {
    return ThemeData.dark().copyWith(
      scaffoldBackgroundColor: Palette.background,
      cardColor: Palette.card,
      hoverColor: Colors.transparent,
      focusColor: Palette.focus,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      disabledColor: Palette.suppressed,
      canvasColor: Palette.card,
      hintColor: Palette.suppressed,
      dialogTheme: DialogTheme(
        backgroundColor: Palette.card,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(cardCornerRadius)),
      ),
      colorScheme: const ColorScheme.dark(primary: Palette.highlight),
      tooltipTheme: const TooltipThemeData(
        waitDuration: Duration(milliseconds: 350),
        decoration: BoxDecoration(
          color: Palette.card,
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        textStyle: TextStyle(
          fontFamily: 'Noto Sans',
          color: Palette.highlight,
        ),
      ),
      dividerColor: Colors.transparent,
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Palette.highlight,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: Palette.highlight,
          fontSize: 64,
          height: 0.8,
          leadingDistribution: TextLeadingDistribution.even,
          fontFamily: 'M PLUS Rounded 1c',
        ),
        headlineLarge: TextStyle(
          color: Palette.standard,
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
          color: Palette.highlight,
          fontSize: 20,
        ),
        titleMedium: TextStyle(
          fontFamily: 'Noto Sans',
          color: Palette.standard,
        ),
        bodyMedium: TextStyle(
          fontFamily: 'Noto Sans',
          color: Palette.standard,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          textStyle: MaterialStateProperty.resolveWith<TextStyle?>(
            (Set<MaterialState> states) => const TextStyle(
              fontFamily: 'Noto Sans',
            ),
          ),
          backgroundColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.hovered)) {
                return Palette.focus;
              }
              return Colors.transparent;
            },
          ),
          foregroundColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.hovered)) {
                return Palette.highlight;
              }
              return Palette.standard;
            },
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          textStyle: MaterialStateProperty.resolveWith<TextStyle?>(
            (Set<MaterialState> states) => const TextStyle(
              fontFamily: 'Noto Sans',
              fontSize: 20,
            ),
          ),
          backgroundColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.hovered)) {
                return Palette.focus;
              }
              return Colors.transparent;
            },
          ),
          foregroundColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.hovered)) {
                return Palette.highlight;
              }
              return Palette.standard;
            },
          ),
        ),
      ),
    );
  }
}
