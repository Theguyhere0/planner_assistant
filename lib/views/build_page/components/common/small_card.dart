import 'package:flutter/material.dart';

import '../../../../utils/constants.dart';

/// A small card for a [PageSection].
///
/// Three of these are meant to fit in a row of a [PageSection].
class SmallCard extends StatelessWidget {
  const SmallCard(
    this.title, {
    Key? key,
    required this.content,
  }) : super(key: key);

  final String title;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
