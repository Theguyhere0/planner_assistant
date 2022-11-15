import 'package:flutter/material.dart';

import '../../../theme/palette.dart';

/// A class to standardize deletion confirmation across the app.
class DeleteDialog extends StatelessWidget {
  /// Creates a standard deletion confirmation dialog customized for the UI of this app.
  const DeleteDialog({
    Key? key,
    required this.title,
  }) : super(key: key);

  /// The dialog header.
  final String title;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Delete'),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.hovered)) {
                  return Palette.focus;
                }
                return Colors.transparent;
              },
            ),
            foregroundColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.hovered)) {
                  return Palette.highlight;
                }
                return Palette.failure;
              },
            ),
          ),
        ),
      ],
    );
  }
}
