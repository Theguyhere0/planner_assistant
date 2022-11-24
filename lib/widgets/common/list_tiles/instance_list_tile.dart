import 'package:flutter/material.dart';

import '../../../theme/palette.dart';
import '../buttons/delete_button.dart';

/// A tile for custom lists for editing an element.
class InstanceListTile extends StatelessWidget {
  /// Creates a tile for displaying an element.
  const InstanceListTile(
    this.name, {
    Key? key,
    required this.type,
    required this.dialog,
    required this.delete,
  }) : super(key: key);

  /// The name of the element.
  final String name;

  /// The type of element being displayed.
  final String type;

  /// A callback for the dialog to display when clicked.
  final void Function(String) dialog;

  /// The function to call to delete this instance.
  final void Function(String) delete;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Container(
        alignment: Alignment.topLeft,
        child: Text(name),
      ),
      trailing: DeleteButton(
        title: 'Delete $type: $name?',
        delete: () => delete(name),
      ),
      tileColor: Palette.card,
      hoverColor: Palette.focus,
      onTap: () => dialog(name),
    );
  }
}
