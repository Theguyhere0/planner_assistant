import 'package:flutter/material.dart';

import '../common/card_tiles/list_card_tile.dart';
import '../common/cards/small_card.dart';
import '../common/card_tiles/text_field_card_tile.dart';

class ActivityUnitSettingsCard extends StatelessWidget {
  const ActivityUnitSettingsCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SmallCard(
      'Activity Unit Settings',
      infoContent:
          'Set how activity units behave in this project. All settings are optional or have default values.',
      content: Column(children: const <Widget>[
        TextFieldCardTile(
          'General Name',
          hintText: 'Activity Unit',
        ),
        TextFieldCardTile(
          'Plural Form',
          hintText: 'Activity Units',
        ),
        ListCardTile(title: 'Properties'),
      ]),
    );
  }
}
