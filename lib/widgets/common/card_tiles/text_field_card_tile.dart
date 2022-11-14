import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

/// A tile for custom cards with a field for text.
class TextFieldCardTile extends StatelessWidget {
  /// Creates a card tile with a field for text.
  const TextFieldCardTile(
    this.title, {
    required this.hintText,
    Key? key,
  }) : super(key: key);

  /// What the text input is for.
  final String title;

  /// Default option or hint for what to input.
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        child: Text(
          title,
          textAlign: TextAlign.right,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        width: cardTileTitleWidth,
        alignment: Alignment.centerRight,
      ),
      title: TextFormField(
        decoration: InputDecoration(
          border: const UnderlineInputBorder(),
          hintText: hintText,
        ),
      ),
    );
  }
}
