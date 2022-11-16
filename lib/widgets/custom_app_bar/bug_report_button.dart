import 'package:flutter/material.dart';

import 'custom_icon_button.dart';

/// A button to easily report any bugs a user may experience.
class BugReportButton extends StatelessWidget {
  const BugReportButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CustomIconButton(
      icon: Icons.bug_report_rounded,
      tooltip: 'Report a bug',
      onPressed: null, // TODO: Open issue report in new tab
    );
  }
}
