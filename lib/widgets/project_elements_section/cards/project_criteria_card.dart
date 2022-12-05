import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/project_controller.dart';
import '../../common/card_tiles/ranked_list_card_tile.dart';
import '../../common/cards/small_card.dart';
import '../../../utils/constants.dart';
import '../dialogs/criterion_dialog.dart';

/// A card for managing the criteria of the project.
class ProjectCriteriaCard extends ConsumerWidget {
  const ProjectCriteriaCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void delete(name) {
      ref.read(projectControllerProvider.notifier)
        ..loadBufferedCriterion(name)
        ..removeBufferedCriterion();
    }

    return SmallCard(
      'Project Criteria',
      infoContent: 'Add criteria that this project should optimize for.',
      content: Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: RankedListCardTile(
            type: 'Project Criteria',
            dialog: (name) {
              ref
                  .read(projectControllerProvider.notifier)
                  .loadBufferedCriterion(name);
              showDialog(
                context: context,
                builder: (context) => StatefulBuilder(
                  builder: (context, setState) => CriterionDialog(
                    setState: setState,
                    delete: delete,
                  ),
                ),
              );
            },
            instances: ref.watch(projectControllerProvider).criteria.getAll(),
            onReorder: (oldIndex, newIndex) {
              ref.read(projectControllerProvider.notifier).reOrderCriteria(
                  oldIndex + 1, newIndex > oldIndex ? newIndex : ++newIndex);
            },
            createNew: () {
              ref.read(projectControllerProvider.notifier).resetBuffers();
              showDialog(
                context: context,
                builder: (context) => StatefulBuilder(
                  builder: (context, setState) =>
                      CriterionDialog(setState: setState),
                ),
              );
            },
            delete: delete,
          ),
        ),
      ]),
    );
  }
}
