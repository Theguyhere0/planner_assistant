import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../theme/palette.dart';
import '../../../utils/constants.dart';

/// A tile for custom cards with a field for integer numbers.
class IntegerFieldCardTile extends StatelessWidget {
  /// Creates a card tile with a field for integer numbers.
  const IntegerFieldCardTile(
    this.title, {
    this.hintText,
    this.units,
    this.prefix = false,
    required this.value,
    this.onChanged,
    this.validator,
    Key? key,
  }) : super(key: key);

  /// What the number is counting for.
  final String title;

  /// Default option or hint for what to input.
  final String? hintText;

  /// The units at the number represent.
  final String? units;

  /// Whether the units should go before or after the number.
  final bool prefix;

  /// What value the integer input holds.
  final int? value;

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
          // Units in prefix mode
          Visibility(
            visible: prefix && units != null,
            child: Padding(
              padding: const EdgeInsets.only(right: defaultPadding),
              child: Text(
                units ?? '',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Palette.suppressed),
              ),
            ),
          ),
          // Number input field
          SizedBox(
            width: 60,
            child: TextFormField(
              initialValue: value?.toString(),
              decoration: InputDecoration(
                hintText: hintText,
                border: const UnderlineInputBorder(),
              ),
              keyboardType: const TextInputType.numberWithOptions(signed: true),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp('^-?[0-9]*'))
              ],
              onChanged: onChanged,
              validator: validator,
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
          ),
          // Units in suffix mode
          Visibility(
            visible: !prefix && units != null,
            child: Padding(
              padding: const EdgeInsets.only(left: defaultPadding),
              child: Text(
                units ?? '',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Palette.suppressed),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
