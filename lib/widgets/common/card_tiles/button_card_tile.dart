import 'package:flutter/material.dart';

/// A tile for custom cards with a button.
class ButtonCardTile extends StatelessWidget {
  /// Creates a card tile with a button.
  const ButtonCardTile(
    this.title, {
    required this.icon,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  /// Button text.
  final String title;

  /// Button icon.
  final IconData icon;

  /// What the button does when pressed.
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Container(
        alignment: Alignment.center,
        child: OutlinedButton.icon(
          onPressed: onPressed,
          icon: Icon(
            icon,
            size: 24,
          ),
          label: Text(title),
        ),
      ),
    );
  }
}
