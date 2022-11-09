import 'package:flutter/material.dart';

import '../common/small_card.dart';
import '../common/text_field_card_tile.dart';

class TimeUnitSettingsCard extends StatelessWidget {
  const TimeUnitSettingsCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SmallCard(
      'Time Unit Settings',
      content: Column(children: const <Widget>[
        TextFieldCardTile(
          'Name',
          hintText: 'Time Unit',
        ),
      ]),
    );
  }
}
