import 'package:flutter/material.dart';

import '../../../../utils/constants.dart';

/// A medium card for a [PageSection].
///
/// One of these is meant to fit in a row of a [PageSection], along with a [SmallCard].
class MediumCard extends StatelessWidget {
  const MediumCard(
    this.title, {
    Key? key,
    required this.content,
  }) : super(key: key);

  final String title;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: defaultPadding),
          child: Column(
            children: <Widget>[
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              content,
            ],
          ),
        ),
      ),
    );
  }
}
