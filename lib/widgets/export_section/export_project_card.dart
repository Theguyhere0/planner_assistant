import 'package:flutter/material.dart';

import '../common/cards/small_card.dart';

class ExportProjectCard extends StatelessWidget {
  const ExportProjectCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SmallCard(
      'Save a Project',
      infoContent:
          'Save the project settings, along with any important plans, in a data file to open up later.',
      content: Column(children: const <Widget>[]),
    );
  }
}
