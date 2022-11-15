import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

/// A tile for custom cards with a toggle switch.
class ToggleCardTile extends StatelessWidget {
  /// Creates a card tile with a toggle switch.
  const ToggleCardTile(
    this.title, {
    required this.leftToggleOption,
    required this.rightToggleOption,
    Key? key,
  }) : super(key: key);

  /// What the toggle selection is for.
  final String title;

  /// What option is selected when the toggle is switched to the left.
  final String leftToggleOption;

  /// What option is selected when the toggle is switched to the right.
  final String rightToggleOption;

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
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(leftToggleOption),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Switch(
              value: false,
              onChanged: null,
            ),
          ),
          Text(rightToggleOption),
        ],
      ),
    );
  }
}
