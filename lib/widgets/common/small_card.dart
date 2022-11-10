import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import '../common/info_button.dart';

/// A small card for a [PageSection].
///
/// Three of these are meant to fit in a row of a [PageSection].
class SmallCard extends StatelessWidget {
  const SmallCard(
    this.title, {
    Key? key,
    required this.infoContent,
    required this.content,
  }) : super(key: key);

  final String title;
  final String infoContent;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(cardCornerRadius)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: defaultPadding),
          child: Column(
            children: <Widget>[
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
              content,
            ],
          ),
        ),
      ),
    );
  }
}
