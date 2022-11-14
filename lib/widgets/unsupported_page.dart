import 'package:flutter/material.dart';

import '../theme/palette.dart';
import '../utils/constants.dart';

class UnsupportedPage extends StatelessWidget {
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
      child: Center(
        child: Text(
          'This window size is currently unsupported.',
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: Palette.failure,
              ),
        ),
      ),
    );
  }
}
