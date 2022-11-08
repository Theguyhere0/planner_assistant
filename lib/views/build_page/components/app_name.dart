import 'package:flutter/material.dart';
import 'package:planner_assistant/utils/constants.dart';

class AppName extends StatelessWidget {
  const AppName({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: defaultPadding),
      child: const Align(
        alignment: Alignment.bottomCenter,
        child: Text(
          'Planner Assistant',
          textAlign: TextAlign.left,
          style: TextStyle(
            color: primaryTextColor,
            fontSize: 64,
            height: 0.8,
            leadingDistribution: TextLeadingDistribution.even,
            fontFamily: 'M PLUS Rounded 1c',
          ),
        ),
      ),
    );
  }
}
