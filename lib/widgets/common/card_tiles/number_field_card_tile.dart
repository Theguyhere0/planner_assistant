import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../utils/constants.dart';

/// A tile for custom cards with a field for numbers.
class NumberFieldCardTile extends StatelessWidget {
  /// Creates a card tile with a field for numbers.
  const NumberFieldCardTile(
    this.title, {
    this.hintText,
    required this.units,
    this.prefix = false,
    required this.value,
    this.onChanged,
    this.validator,
    Key? key,
  }) : super(key: key);

  /// What the numbers are counting for.
  final String title;

  /// Default option or hint for what to input.
  final String? hintText;

  /// The units at the numbers represent.
  final String units;

  /// Whether the units should go before or after the number.
  final bool prefix;

  /// What value the number input holds.
  final String? value;

  /// What should happen when changes occur.
  final void Function(String)? onChanged;

  /// Verifies the input is valid.
  final String? Function(String?)? validator;

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
      title: Row(
        children: <Widget>[
          Visibility(
            visible: prefix,
            child: Padding(
              padding: const EdgeInsets.only(right: defaultPadding),
              child: Text(units),
            ),
          ),
          SizedBox(
            width: 60,
            child: TextFormField(
              initialValue: value,
              decoration: InputDecoration(
                hintText: hintText,
                border: const UnderlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              onChanged: onChanged,
              validator: validator,
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
          ),
          Visibility(
            visible: !prefix,
            child: Padding(
              padding: const EdgeInsets.only(left: defaultPadding),
              child: Text(units),
            ),
          ),
        ],
      ),
    );
  }
}
