import 'package:flutter/material.dart';

import '../../../theme/palette.dart';
import '../delete_button.dart';

class InstanceListTile extends StatelessWidget {
  const InstanceListTile(
    this.name, {
    Key? key,
    required this.type,
  }) : super(key: key);

  final String name;
  final String type;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Container(
        child: Text(name),
        alignment: Alignment.topLeft,
      ),
      trailing: DeleteButton(title: 'Delete $type?'),
      tileColor: Palette.card,
      hoverColor: Palette.focus,
      onTap: () {},
    );
  }
}
