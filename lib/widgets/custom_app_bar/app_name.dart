import 'package:flutter/material.dart';

import '../../utils/constants.dart';

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
        child: Text(
          'Planner Assistant',
          textAlign: TextAlign.left,
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
    );
  }
}
