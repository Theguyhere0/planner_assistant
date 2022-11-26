import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

/// A tile for custom cards with two s.
class DoubleButtonCardTile extends StatelessWidget {
  /// Creates a card tile with two buttons.
  const DoubleButtonCardTile({
    required this.firstLabel,
    required this.secondLabel,
    required this.firstIcon,
    required this.secondIcon,
    this.firstOnPressed,
    this.secondOnPressed,
    Key? key,
  }) : super(key: key);

  /// First button text.
  final String firstLabel;

  /// First button icon.
  final IconData firstIcon;

  /// What the first button does when pressed.
  final void Function()? firstOnPressed;

  /// Second button text.
  final String secondLabel;

  /// Second button icon.
  final IconData secondIcon;

  /// What the second button does when pressed.
  final void Function()? secondOnPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Button one
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: OutlinedButton.icon(
              onPressed: firstOnPressed,
              icon: Icon(
                firstIcon,
                size: 24,
              ),
              label: Text(firstLabel),
            ),
          ),
          // Button two
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: OutlinedButton.icon(
              onPressed: secondOnPressed,
              icon: Icon(
                secondIcon,
                size: 24,
              ),
              label: Text(secondLabel),
            ),
          ),
        ],
      ),
    );
  }
}
