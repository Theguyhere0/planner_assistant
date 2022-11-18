import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'theme/custom_theme.dart';
import 'utils/responsive.dart';
import 'widgets/build_page.dart';
import 'widgets/unsupported_page.dart';

void main(List<String> args) =>
    runApp(const ProviderScope(child: PlannerAssistantApp()));

class PlannerAssistantApp extends StatelessWidget {
  const PlannerAssistantApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Just to make the debug screen look pretty
      debugShowCheckedModeBanner: false,
      title: 'Planner Assistant',
      // Set up custom theme for the entire app
      theme: CustomTheme.theme(),
      // Display app only if the screen is within desktop width limit
      home: const Scaffold(
        body: Responsive(
          desktop: BuildPage(),
          mobile: UnsupportedPage(),
        ),
      ),
    );
  }
}
