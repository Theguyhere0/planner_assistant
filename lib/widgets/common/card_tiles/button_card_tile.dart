import 'package:flutter/material.dart';

class ButtonCardTile extends StatelessWidget {
  const ButtonCardTile(
    this.title, {
    required this.icon,
    Key? key,
  }) : super(key: key);

  final String title;
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
