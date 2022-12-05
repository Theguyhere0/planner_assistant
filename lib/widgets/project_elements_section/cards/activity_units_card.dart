import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/project_controller.dart';
import '../../common/cards/small_card.dart';
import '../../common/card_tiles/list_card_tile.dart';
import '../../../utils/constants.dart';
import '../../../utils/extensions.dart';
import '../dialogs/activity_unit_dialog.dart';

/// A card for managing the activity units of the project.
class ActivityUnitsCard extends ConsumerWidget {
  const ActivityUnitsCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void delete(name) {
      ref.read(projectControllerProvider.notifier)
        ..loadBufferedActivityUnit(name)
        ..removeBufferedActivityUnit();
    }

    return SmallCard(
      ref
          .watch(projectControllerProvider)
          .displayActivityUnitPluralName
          .toTitleCase(),
      infoContent:
          'Create and define the activity units that this project will work with to create plans.',
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        child: ListCardTile(
          type: ref.watch(projectControllerProvider).displayActivityUnitName,
          dialog: (name) {
            ref
                .read(projectControllerProvider.notifier)
                .loadBufferedActivityUnit(name);
            showDialog(
              context: context,
              builder: (context) => StatefulBuilder(
                builder: (context, setState) => ActivityUnitDialog(
                  setState: setState,
                  delete: delete,
                ),
              ),
            );
          },
          instances:
              ref.watch(projectControllerProvider).activityUnits.getAll(),
          createNew: () {
            ref.read(projectControllerProvider.notifier).resetBuffers();
            showDialog(
              context: context,
              builder: (context) => StatefulBuilder(
                builder: (context, setState) =>
                    ActivityUnitDialog(setState: setState),
              ),
            );
          },
          delete: delete,
        ),
      ),
    );
  }
}
