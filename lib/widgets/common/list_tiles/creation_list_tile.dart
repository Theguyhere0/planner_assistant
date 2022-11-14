import 'package:flutter/material.dart';

import '../../../theme/palette.dart';

class CreationListTile extends StatelessWidget {
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
