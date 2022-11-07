import 'package:planner_assistant/utils/constants.dart';
import 'package:planner_assistant/views/getting_started/components/import_profile_button.dart';
import 'package:planner_assistant/views/getting_started/components/new_profile_button.dart';
import 'package:planner_assistant/views/getting_started/components/welcome_message.dart';
import 'package:flutter/material.dart';

class GettingStarted extends StatelessWidget {
  const GettingStarted({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // Logo
          Container(
            child: Placeholder(),
            margin: EdgeInsets.all(defaultPadding),
            width: 50,
            height: 50,
          ),
          Flexible(
            fit: FlexFit.tight,
            child: Container(
              child: WelcomeMessage(),
              margin: EdgeInsets.all(defaultPadding),
            ),
          ),
          Flexible(
            child: Container(
              child: NewProfileButton(),
              margin: EdgeInsets.all(defaultPadding),
            ),
          ),
          Flexible(
            child: Container(
              child: ImportProfileButton(),
              margin: EdgeInsets.all(defaultPadding),
            ),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }
}
