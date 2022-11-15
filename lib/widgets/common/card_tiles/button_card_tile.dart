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
        child: OutlinedButton.icon(
          onPressed: () {},
          icon: Icon(
            icon,
            size: 24,
          ),
          label: Text(title),
        ),
        alignment: Alignment.center,
      ),
    );
  }
}
