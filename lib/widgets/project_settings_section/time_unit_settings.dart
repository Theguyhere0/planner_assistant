import 'package:flutter/material.dart';

import '../common/cards/small_card.dart';
import '../common/card_tiles/text_field_card_tile.dart';
import '../common/card_tiles/list_card_tile.dart';

class TimeUnitSettingsCard extends StatelessWidget {
  const TimeUnitSettingsCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SmallCard(
      'Time Unit Settings',
      infoContent:
          'Set how time units behave in this project. Labels provide a descriptor for time units (ex. Monday, Spring 2022). All settings are optional or have default values.',
      content: Column(children: const <Widget>[
        TextFieldCardTile(
          'Name',
          hintText: 'Time Unit',
        ),
        TextFieldCardTile(
          'Plural Form',
          hintText: 'Time Units',
        ),
        ListCardTile(title: 'Labels')
      ]),
    );
  }
}
