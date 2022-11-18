import 'package:flutter/material.dart';

import '../../../utils/constants.dart';
import '../buttons/info_button.dart';

/// A large card for a [PageSection].
///
/// Only one of these is meant to fit in a row of a [PageSection].
class LargeCard extends StatelessWidget {
  /// Creates a large content card.
  const LargeCard(
    this.title, {
    Key? key,
    required this.infoContent,
    required this.content,
  }) : super(key: key);

  /// Name of the card.
  final String title;

  /// The help information associated with this card.
  final String infoContent;

  /// Content inside the card.
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(cardCornerRadius)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: defaultPadding),
        child: Column(
          children: <Widget>[
            // Title
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                InfoButton(
                  title: title,
                  content: infoContent,
                )
              ],
            ),
            // Card content
            content,
          ],
        ),
      ),
    );
  }
}
