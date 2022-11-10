import 'package:flutter/material.dart';

import 'custom_icon_button.dart';

class BugReportButton extends StatelessWidget {
  const BugReportButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomIconButton(
      icon: Icons.bug_report_rounded,
      tooltip: 'Report a bug',
      onPressed: () {}, // TODO: Open issue report in new tab
    );
  }
}
