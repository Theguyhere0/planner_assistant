import 'package:flutter/material.dart';
import 'package:planner_assistant/widgets/common/dialogs/card_dialog.dart';

import '../../../theme/palette.dart';
import '../buttons/delete_button.dart';

/// A tile for custom lists for editing an element.
class InstanceListTile extends StatelessWidget {
  /// Creates a tile for displaying an element.
  const InstanceListTile(
    this.name, {
    Key? key,
    required this.type,
    required this.content,
  }) : super(key: key);

  /// The name of the element.
  final String name;

  /// The type of element being displayed.
  final String type;

  /// The card content to display.
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Container(
        alignment: Alignment.topLeft,
        child: Text(name),
      ),
      trailing: DeleteButton(title: 'Delete $type?'),
      tileColor: Palette.card,
      hoverColor: Palette.focus,
      onTap: () => showDialog(
        context: context,
        builder: (BuildContext context) => CardDialog(
          title: '$type: $name',
          content: content,
        ),
      ),
    );
  }
}
