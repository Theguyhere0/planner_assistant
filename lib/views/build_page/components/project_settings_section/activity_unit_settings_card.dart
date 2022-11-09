import 'package:flutter/material.dart';

import '../common/number_field_card_tile.dart';
import '../common/small_card.dart';
import '../common/text_field_card_tile.dart';
import '../common/toggle_card_tile.dart';

class ActivityUnitSettingsCard extends StatelessWidget {
  const ActivityUnitSettingsCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SmallCard(
      'Activity Unit Settings',
      content: Column(children: const <Widget>[
        TextFieldCardTile(
          'Name',
          hintText: 'Activity Unit',
        ),
        ToggleCardTile(
          'Type',
          leftToggleOption: 'Unique',
          rightToggleOption: 'Repeatable',
        ),
        NumberFieldCardTile(
          'Duration',
          units: 'Time Units',
        ),
      ]),
    );
  }
}
