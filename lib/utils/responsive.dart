import 'package:flutter/material.dart';

/// A class to help render components responsively
class Responsive extends StatelessWidget {
  const Responsive({
    Key? key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  }) : super(key: key);

  /// Mobile configuration
  final Widget mobile;

  /// Tablet configuration
  final Widget? tablet;

  /// Desktop configuration
  final Widget desktop;

  /// Checks whether the page should be rendered in mobile mode
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 850;

  /// Checks whether the page should be rendered in tablet mode
  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1100 &&
      MediaQuery.of(context).size.width >= 850;

  /// Checks whether the page should be rendered in desktop mode
  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    // If width is more than 1100 then it is considered desktop
    if (_size.width >= 1100) {
      return desktop;
    }

    // If width is less than 1100 and more than 850, it is considered tablet, if tablet exists
    else if (_size.width >= 850 && tablet != null) {
      return tablet!;
    }

    // Otherwise, it is considered mobile
    else {
      return mobile;
    }
  }
}
