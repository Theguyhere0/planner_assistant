import 'package:flutter/material.dart';

/// A class to standardize popup for editing across the app.
class CardDialog extends StatelessWidget {
  /// Creates a standard editing dialog customized for the UI of this app.
  const CardDialog({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  /// The dialog header.
  final String title;

  /// The card content to display.
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(child: Text(title)),
      scrollable: true,
      content: SizedBox(
        width: 750,
        child: content,
      ),
    );
  }
}
