import 'package:flutter/material.dart';

import '../../../theme/palette.dart';
import '../buttons/delete_button.dart';

/// A tile for custom lists for editing a ranked elements.
class RankedListTile extends StatelessWidget {
  /// Creates a tile for displaying ranked elements.
  const RankedListTile(
    this.name, {
    required Key key,
    required this.type,
    required this.index,
    required this.height,
    required this.dialog,
    required this.delete,
  }) : super(key: key);

  /// The name of the element.
  final String name;

  /// The type of element being displayed.
  final String type;

  /// The index of the element in the list.
  final int index;

  /// The height of this tile.
  final double height;

  /// A callback for the dialog to display when clicked.
  final void Function(String) dialog;

  /// The function to call to delete this instance.
  final void Function(String) delete;

  @override
  Widget build(BuildContext context) {
    return LimitedBox(
      maxHeight: height,
      child: ListTile(
        leading: ReorderableDragStartListener(
          index: index,
          child: Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Container(
              width: 20,
              alignment: Alignment.topLeft,
              child: Text('${index + 1}.'),
            ),
          ),
        ),
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
      ),
    );
  }
}
