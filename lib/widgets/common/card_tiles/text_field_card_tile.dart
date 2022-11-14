import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class TextFieldCardTile extends StatelessWidget {
  const TextFieldCardTile(
    this.title, {
    required this.hintText,
    Key? key,
  }) : super(key: key);

  final String title;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        child: Text(
          title,
          textAlign: TextAlign.right,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        width: cardTileTitleWidth,
        alignment: Alignment.centerRight,
      ),
      title: TextFormField(
        decoration: InputDecoration(
          border: const UnderlineInputBorder(),
          hintText: hintText,
        ),
      ),
    );
  }
}
