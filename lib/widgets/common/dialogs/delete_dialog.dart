import 'package:flutter/material.dart';

import '../../../theme/palette.dart';

/// A class to standardize deletion confirmation across the app.
class DeleteDialog extends StatelessWidget {
  /// Creates a standard deletion confirmation dialog customized for the UI of this app.
  const DeleteDialog({
    Key? key,
    required this.title,
    required this.delete,
  }) : super(key: key);

  /// The dialog header.
  final String title;

  /// The function to call to perform the delete.
  final void Function() delete;

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
            delete();
            Navigator.pop(context);
          },
          style: Theme.of(context).textButtonTheme.style?.copyWith(
            foregroundColor: MaterialStateProperty.resolveWith<Color?>(
              (states) {
                if (states.contains(MaterialState.hovered)) {
                  return Palette.highlight;
                }
                return Palette.failure;
              },
            ),
          ),
          child: const Text('Delete'),
        ),
      ],
    );
  }
}
