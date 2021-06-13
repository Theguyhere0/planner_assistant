import 'package:course_schedule_maker/views/getting_started/getting_started.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants.dart';

void main(List<String> args) => runApp(CSMApp());

class CSMApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Course Schedule Maker',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),
      home: Scaffold(
        body: GettingStarted(),
      ),
    );
  }
}

// class CSMApp extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return _CSMState();
//   }
// }

// class _CSMState extends State<CSMApp> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('My First App'),
//         ),
//       ),
//     );
//   }
// }
