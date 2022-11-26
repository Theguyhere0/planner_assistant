import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

/// A tile for custom cards with a field for text.
class TextFieldCardTile extends StatelessWidget {
  /// Creates a card tile with a field for text.
  const TextFieldCardTile(
    this.title, {
    required this.hintText,
    required this.value,
    this.onChanged,
    this.validator,
    this.autofocus = false,
    Key? key,
  }) : super(key: key);

  /// What the text input is for.
  final String title;

  /// Default option or hint for what to input.
  final String hintText;

  /// What value the text input holds.
  final String? value;

  /// What the input should do when changes occur.
  final void Function(String)? onChanged;

  /// Verifies the input is valid.
  final String? Function(String? value)? validator;

  /// Whether or not this field should be focused on when first rendered.
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: cardTileTitleWidth,
        alignment: Alignment.centerRight,
        child: Text(
          title,
          textAlign: TextAlign.right,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      title: TextFormField(
        initialValue: value,
        decoration: InputDecoration(
          border: const UnderlineInputBorder(),
          hintText: hintText,
        ),
        onChanged: onChanged,
        validator: validator,
        autofocus: autofocus,
        autovalidateMode: AutovalidateMode.onUserInteraction,
      ),
    );
  }
}
