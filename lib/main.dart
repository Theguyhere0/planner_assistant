import 'package:flutter/material.dart';

import 'theme/custom_theme.dart';
import 'widgets/build_page.dart';

void main(List<String> args) => runApp(const PlannerAssistantApp());

class PlannerAssistantApp extends StatelessWidget {
  const PlannerAssistantApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Planner Assistant',
      theme: CustomTheme.theme(),
      home: const Scaffold(
        body: BuildPage(),
      ),
    );
  }
}
