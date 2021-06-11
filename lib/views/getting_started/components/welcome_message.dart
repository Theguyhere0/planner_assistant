import 'package:flutter/material.dart';

/// The welcome message for the first-time boot of this app.
class WelcomeMessage extends StatelessWidget {
  const WelcomeMessage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Welcome to Course Schedule Maker',
      textAlign: TextAlign.center,
      style: TextStyle(
          color: Color(0xffffffff), fontFamily: 'Poppins', fontSize: 60),
    );
  }
}
