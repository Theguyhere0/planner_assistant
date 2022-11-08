import 'package:flutter/material.dart';
import 'package:planner_assistant/utils/constants.dart';

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
          children: const <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Text(
                'v0.1.0',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: secondaryTextColor,
                  fontSize: 32,
                  height: 0.8,
                  leadingDistribution: TextLeadingDistribution.even,
                  fontFamily: 'M PLUS Rounded 1c',
                ),
              ),
            ),
            Text(
              'Built by Theguyhere',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: suppressedTextColor,
                fontSize: 20,
                height: 0.8,
                leadingDistribution: TextLeadingDistribution.even,
                fontFamily: 'M PLUS Rounded 1c',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
