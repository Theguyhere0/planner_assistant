import 'package:flutter/material.dart';

/// A tile for custom cards with a button.
class ButtonCardTile extends StatelessWidget {
  /// Creates a card tile with a button.
  const ButtonCardTile(
    this.title, {
    required this.icon,
    Key? key,
  }) : super(key: key);

  /// Button text.
  final String title;

  /// Button icon.
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Container(
        alignment: Alignment.center,
        child: OutlinedButton.icon(
          onPressed: null,
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
