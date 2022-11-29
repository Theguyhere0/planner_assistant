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
    final scrollController = ScrollController();

    return AlertDialog(
      title: Center(child: Text(title)),
      contentPadding:
          const EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 30),
      content: SizedBox(
        width: 750,
        child: Scrollbar(
          thumbVisibility: true,
          controller: scrollController,
          child: SingleChildScrollView(
            controller: scrollController,
            child: content,
          ),
        ),
      ),
    );
  }
}
