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
