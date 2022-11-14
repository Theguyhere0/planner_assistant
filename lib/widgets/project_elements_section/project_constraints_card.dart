import 'package:flutter/material.dart';

import '../common/cards/small_card.dart';
import '../common/card_tiles/list_card_tile.dart';
import '../../utils/constants.dart';

/// A card for managing the constraints of the project.
class ProjectConstraintsCard extends StatelessWidget {
  const ProjectConstraintsCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SmallCard(
      'Project Constraints',
      infoContent: 'Add constraints that apply to the entire project.',
      content: Column(children: const <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: defaultPadding),
          child: ListCardTile(),
        ),
      ]),
    );
  }
}
