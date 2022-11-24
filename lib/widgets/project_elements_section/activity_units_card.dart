import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/project_controller.dart';
import '../common/cards/small_card.dart';
import '../common/card_tiles/list_card_tile.dart';
import '../../utils/constants.dart';
import '../../utils/extensions.dart';

/// A card for managing the activity units of the project.
class ActivityUnitsCard extends ConsumerWidget {
  const ActivityUnitsCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SmallCard(
      ref
          .watch(projectControllerProvider)
          .displayActivityUnitPluralName
          .toTitleCase(),
      infoContent:
          'Input the activity units that this project needs to work with.',
      content: Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: ListCardTile(
            dialog: (setState) => const Text('test'),
            instances: ref.watch(projectControllerProvider).activityUnits.when(
                  data: (data) => data,
                  error: ((error, stackTrace) => []),
                  loading: (() => []),
                ),
            createNew: () {},
            delete: () {},
          ),
        ),
      ]),
    );
  }
}
