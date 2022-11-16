import 'package:flutter/material.dart';

import '../../../theme/palette.dart';
import '../delete_button.dart';

/// A tile for custom lists for editing an element.
class InstanceListTile extends StatelessWidget {
  /// Creates a tile for displaying an element.
  const InstanceListTile(
    this.name, {
    Key? key,
    required this.type,
  }) : super(key: key);

  /// The name of the element.
  final String name;

  /// The type of element being displayed.
  final String type;

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
      onTap: () {},
    );
  }
}
