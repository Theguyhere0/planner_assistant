import 'package:flutter/material.dart';

import '../theme/palette.dart';
import '../utils/constants.dart';

/// This is a placeholder page to display when the screen width is not supported.
class UnsupportedPage extends StatelessWidget {
  /// Creates a placeholder page for screen width errors.
  const UnsupportedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // Bottom side shouldn't matter if it gets cut off
      bottom: false,
      // Provide page margin on all sides that matter
      minimum: const EdgeInsets.only(
        left: pageSidePadding - defaultPadding * 2,
        right: pageSidePadding - defaultPadding * 2,
        top: pageTopPadding,
      ),
      // Error text
      child: Center(
        child: Text(
          'This window size is currently unsupported. Please open on desktop.',
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: Palette.failure,
              ),
        ),
      ),
    );
  }
}
