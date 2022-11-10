import 'package:flutter/material.dart';

import '../common/small_card.dart';

class ActivityUnitsCard extends StatelessWidget {
  const ActivityUnitsCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SmallCard(
      'Activity Units',
      infoContent:
          'Input the activity units that this project needs to work with.',
      content: Column(children: const <Widget>[]),
    );
  }
}
