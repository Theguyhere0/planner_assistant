import 'package:flutter/material.dart';
import 'package:planner_assistant/utils/constants.dart';

class BugReportButton extends StatelessWidget {
  const BugReportButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const IconButton(
      onPressed: null,
      icon: Icon(Icons.bug_report_rounded),
      iconSize: 45,
      padding: EdgeInsets.symmetric(horizontal: 20),
      color: highlightColor,
      hoverColor: primaryTextColor,
      tooltip: 'Report a bug',
    );
  }
}
