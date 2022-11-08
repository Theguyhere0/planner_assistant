import 'package:flutter/material.dart';
import 'package:planner_assistant/utils/constants.dart';
import 'package:planner_assistant/views/build_page/components/app_name.dart';
import 'package:planner_assistant/views/build_page/components/bug_report_button.dart';
import 'package:planner_assistant/views/build_page/components/donation_button.dart';
import 'package:planner_assistant/views/build_page/components/version_and_credits.dart';
import 'package:planner_assistant/views/build_page/components/video_button.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: const <Widget>[
        AppName(),
        VersionAndCredits(),
        Spacer(),
        VideoButton(),
        BugReportButton(),
        DonationButton(),
      ],
    );
  }
}
