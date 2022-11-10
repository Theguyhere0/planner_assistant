import 'package:flutter/material.dart';

import '../../utils/constants.dart';

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
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                'v0.1.0',
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            Text(
              'Built by Theguyhere',
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
      ),
    );
  }
}
