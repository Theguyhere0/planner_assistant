import 'package:flutter/material.dart';
import 'package:planner_assistant/widgets/common/card_tiles/ranked_list_card_tile.dart';

import '../../common/cards/small_card.dart';
import '../../../utils/constants.dart';

/// A card for managing the criteria of the project.
class ProjectCriteriaCard extends StatelessWidget {
  const ProjectCriteriaCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SmallCard(
      'Project Criteria',
      infoContent: 'Add criteria that this project should optimize for.',
      content: Column(children: const <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: defaultPadding),
          child: RankedListCardTile(),
        ),
      ]),
    );
  }
}
