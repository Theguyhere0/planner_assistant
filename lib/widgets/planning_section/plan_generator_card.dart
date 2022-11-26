import 'package:flutter/material.dart';

import '../common/cards/small_card.dart';
import '../common/card_tiles/dropdown_card_tile.dart';
import '../common/card_tiles/button_card_tile.dart';

/// A card automatically generating valid plans for the project.
class PlanGeneratorCard extends StatelessWidget {
  const PlanGeneratorCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SmallCard(
      'Plan Generator',
      infoContent:
          'Automatically generate some plans that might work well for your project.',
      content: Column(children: const <Widget>[
        DropdownCardTile(
          'Time Limit',
          options: [],
          value: null,
        ),
        DropdownCardTile(
          'Plan Limit',
          options: [],
          value: null,
        ),
        ButtonCardTile('Generate Plans', icon: Icons.start_rounded)
      ]),
    );
  }
}
