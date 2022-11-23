import 'package:flutter/material.dart';

import '../../../theme/palette.dart';

/// A tile for custom lists for adding elements.
class CreationListTile extends StatelessWidget {
  /// Creates a tile for adding elements.
  const CreationListTile({Key? key, required this.onClick}) : super(key: key);

  /// What should happen when the tile is clicked.
  final void Function()? onClick;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Container(
        alignment: Alignment.topLeft,
        child: const Text(
          '+ New',
          style: TextStyle(color: Palette.suppressed),
        ),
      ),
      tileColor: Colors.transparent,
      hoverColor: Palette.focus,
      onTap: onClick,
    );
  }
}
