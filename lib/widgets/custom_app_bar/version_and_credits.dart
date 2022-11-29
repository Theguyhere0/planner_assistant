import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../theme/palette.dart';
import '../../utils/constants.dart';
import '../common/hypertext.dart';

/// Some meta information about the app.
class VersionAndCredits extends StatelessWidget {
  const VersionAndCredits({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Version
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Hypertext(
                hypertext: 'v0.3.0',
                normalStyle: Theme.of(context).textTheme.headlineLarge!,
                hypertextStyle: Theme.of(context)
                    .textTheme
                    .headlineLarge!
                    .copyWith(color: Palette.highlight),
                onTap: () {
                  launchUrl(
                    Uri(
                      scheme: 'https',
                      host: 'github.com',
                      path: 'Theguyhere0/planner_assistant/releases/tag/v0.3.0',
                    ),
                  );
                },
              ),
            ),
            // Credits
            Hypertext(
              prefix: 'Built by ',
              hypertext: 'Theguyhere',
              normalStyle: Theme.of(context).textTheme.headlineSmall!,
              hypertextStyle: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: Palette.standard),
              underline: true,
              onTap: () {
                launchUrl(
                  Uri(
                    scheme: 'https',
                    host: 'theguyhere0.github.io',
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
