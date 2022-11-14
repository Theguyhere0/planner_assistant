import 'package:flutter/material.dart';

/// A tile for custom cards with some text.
class TextCardTile extends StatelessWidget {
  /// Creates a card tile with some text.
  const TextCardTile(
    this.title, {
    Key? key,
  }) : super(key: key);

  /// The text to display.
  final String title;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Container(
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        alignment: Alignment.center,
      ),
    );
  }
}
