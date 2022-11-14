import 'package:flutter/material.dart';

import '../../../utils/constants.dart';
import '../info_button.dart';

/// A medium card for a [PageSection].
///
/// One of these is meant to fit in a row of a [PageSection], along with a [SmallCard].
class MediumCard extends StatelessWidget {
  const MediumCard(
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
      flex: 2,
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
