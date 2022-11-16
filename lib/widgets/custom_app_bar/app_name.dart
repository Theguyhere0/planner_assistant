import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/constants.dart';
import '../common/hypertext.dart';

/// The name and face of the app.
class AppName extends StatelessWidget {
  const AppName({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: defaultPadding),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Hypertext(
          hypertext: 'Planner Assistant',
          normalStyle: Theme.of(context).textTheme.displayLarge!,
          onTap: () {
            launchUrl(
              Uri(
                scheme: 'https',
                host: 'github.com',
                path: 'Theguyhere0/planner_assistant',
              ),
            );
          },
        ),
      ),
    );
  }
}
