import 'package:course_schedule_maker/views/getting_started/components/new_profile.dart';
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
          NewProfile(),
          ElevatedButton.icon(
            onPressed: null,
            icon: Icon(Icons.file_download),
            label: Text('Import Profile'),
          ),
        ],
      ),
    );
  }
}
