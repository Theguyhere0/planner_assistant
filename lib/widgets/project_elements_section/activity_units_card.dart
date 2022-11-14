import 'package:flutter/material.dart';

import '../common/cards/small_card.dart';
import '../common/card_tiles/list_card_tile.dart';
import '../../utils/constants.dart';

/// A card for managing the activity units of the project.
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
      content: Column(children: const <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: defaultPadding),
          child: ListCardTile(),
        ),
      ]),
    );
  }
}
