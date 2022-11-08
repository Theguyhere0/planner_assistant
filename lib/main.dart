import 'package:planner_assistant/views/build_page/build_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'utils/constants.dart';

void main(List<String> args) => runApp(const PlannerAssistantApp());

class PlannerAssistantApp extends StatelessWidget {
  const PlannerAssistantApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Planner Assistant',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: cardColor,
      ),
      home: const Scaffold(
        body: BuildPage(),
      ),
    );
  }
}
