import 'package:course_schedule_maker/views/getting_started/components/import_profile.dart';
import 'package:course_schedule_maker/views/getting_started/components/new_profile_button.dart';
import 'package:course_schedule_maker/views/getting_started/components/welcome_message.dart';
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
          Placeholder(
            fallbackHeight: 50,
            fallbackWidth: 50,
          ),
          WelcomeMessage(),
          NewProfileButton(),
          ImportProfileButton(),
        ],
      ),
    );
  }
}
