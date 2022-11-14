import 'package:flutter/material.dart';

/// A class to standardize information popups across the app.
class InfoDialog extends StatelessWidget {
  /// Creates a standard information dialog customized for the UI of this app.
  const InfoDialog({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  /// The dialog header.
  final String title;

  /// The information to display.
  final String content;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: SizedBox(
        child: Text(content),
        width: 750,
      ),
    );
  }
}
