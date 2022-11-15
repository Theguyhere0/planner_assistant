import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import 'app_name.dart';
import 'bug_report_button.dart';
import 'donation_button.dart';
import 'version_and_credits.dart';
import 'video_button.dart';

/// The the top bar of the app with all the necessary header information.
class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: defaultPadding,
        horizontal: defaultPadding * 2,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: const <Widget>[
          AppName(),
          VersionAndCredits(),
          Spacer(),
          VideoButton(),
          BugReportButton(),
          DonationButton(),
        ],
      ),
    );
  }
}
