import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

/// A tile for custom cards with some text.
class TextCardTile extends StatelessWidget {
  /// Creates a card tile with some text.
  const TextCardTile(
    this.title, {
    Key? key,
    this.label,
  }) : super(key: key);

  /// The text to display.
  final String title;

  /// An optional text that becomes the label for this text card tile.
  final String? label;

  @override
  Widget build(BuildContext context) {
    return label == null
        ? ListTile(
            title: Container(
              alignment: Alignment.center,
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          )
        : ListTile(
            horizontalTitleGap: titleGap,
            leading: Container(
              width: cardTileTitleWidth,
              alignment: Alignment.centerRight,
              child: Text(
                label!,
                textAlign: TextAlign.right,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            title: Container(
              alignment: Alignment.topLeft,
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          );
  }
}
