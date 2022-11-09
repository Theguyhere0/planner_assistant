import 'package:flutter/material.dart';

import '../../../../utils/constants.dart';

class BugReportButton extends StatelessWidget {
  const BugReportButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const IconButton(
      onPressed: null,
      icon: Icon(Icons.bug_report_rounded),
      iconSize: appBarButtonSize,
      padding: EdgeInsets.symmetric(horizontal: defaultPadding * 2),
      tooltip: 'Report a bug',
    );
  }
}
