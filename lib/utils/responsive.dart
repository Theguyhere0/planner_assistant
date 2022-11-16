import 'package:flutter/material.dart';

import 'constants.dart';

/// A class to help render components responsively.
class Responsive extends StatelessWidget {
  /// Creates the desired widget depending on screen width.
  const Responsive({
    Key? key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  }) : super(key: key);

  /// Mobile configuration.
  final Widget mobile;

  /// Tablet configuration.
  final Widget? tablet;

  /// Desktop configuration.
  final Widget desktop;

  /// Checks whether the page should be rendered in mobile mode.
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < tabletWidthLimit;

  /// Checks whether the page should be rendered in tablet mode.
  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < desktopWidthLimit &&
      MediaQuery.of(context).size.width >= tabletWidthLimit;

  /// Checks whether the page should be rendered in desktop mode.
  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= desktopWidthLimit;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    // If width is more than desktop width limit, then it is considered desktop
    if (size.width >= desktopWidthLimit) {
      return desktop;
    }

    // If width is less than desktop width limit and more than tablet width limit, it is considered tablet, if tablet exists
    else if (size.width >= tabletWidthLimit && tablet != null) {
      return tablet!;
    }

    // Otherwise, it is considered mobile
    else {
      return mobile;
    }
  }
}
