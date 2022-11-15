import 'package:flutter/material.dart';

import '../../../theme/palette.dart';

/// A tile for custom lists for adding elements.
class CreationListTile extends StatelessWidget {
  /// Creates a tile for adding elements.
  const CreationListTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Container(
        child: const Text(
          '+ New',
          style: TextStyle(color: Palette.suppressed),
        ),
        alignment: Alignment.topLeft,
      ),
      tileColor: Colors.transparent,
      hoverColor: Palette.focus,
      onTap: () {},
    );
  }
}
