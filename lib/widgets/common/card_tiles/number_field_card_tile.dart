import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../utils/constants.dart';

/// A tile for custom cards with a field for numbers.
class NumberFieldCardTile extends StatelessWidget {
  /// Creates a card tile with a field for numbers.
  const NumberFieldCardTile(
    this.title, {
    required this.units,
    Key? key,
  }) : super(key: key);

  /// What the numbers are counting for.
  final String title;

  /// The units at the numbers represent.
  final String units;

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
      title: Row(
        children: <Widget>[
          SizedBox(
            child: TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                hintText: '1',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
            width: 40,
          ),
          Padding(
            padding: const EdgeInsets.only(left: defaultPadding),
            child: Text(units),
          ),
        ],
      ),
    );
  }
}
