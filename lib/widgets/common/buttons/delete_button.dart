import 'package:flutter/material.dart';

import '../../../theme/palette.dart';
import '../../../utils/constants.dart';
import '../dialogs/delete_dialog.dart';

/// A class to standardize deletion buttons across the app.
class DeleteButton extends StatelessWidget {
  /// Creates a standard deletion button customized for the UI of this app.
  const DeleteButton({
    Key? key,
    required this.title,
  }) : super(key: key);

  /// What is begin deleted.
  final String title;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => DeleteDialog(
          title: title,
        ),
      ),
      mouseCursor: SystemMouseCursors.click,
      color: Palette.failure,
      icon: const Icon(Icons.remove_circle_outline_rounded),
      iconSize: infoIconSize,
      padding: const EdgeInsets.all(0),
      alignment: Alignment.topCenter,
    );
  }
}
