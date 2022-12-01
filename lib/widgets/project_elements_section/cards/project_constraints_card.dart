import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/project_controller.dart';
import '../../common/cards/small_card.dart';
import '../../common/card_tiles/list_card_tile.dart';
import '../../../utils/constants.dart';
import '../dialogs/project_constraint_dialog.dart';

/// A card for managing the constraints of the project.
class ProjectConstraintsCard extends ConsumerWidget {
  const ProjectConstraintsCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void delete(name) {
      ref.read(projectControllerProvider.notifier)
        ..loadBufferedProjectConstraint(name)
        ..removeBufferedProjectConstraint();
    }

    return SmallCard(
      'Project Constraints',
      infoContent: 'Add constraints that apply to the entire project.',
      content: Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: ListCardTile(
            type: 'Project Constraint',
            dialog: (name) {
              ref
                  .read(projectControllerProvider.notifier)
                  .loadBufferedProjectConstraint(name);
              showDialog(
                context: context,
                builder: (context) => StatefulBuilder(
                  builder: (context, setState) => ProjectConstraintDialog(
                    setState: setState,
                    delete: delete,
                  ),
                ),
              );
            },
            instances: ref
                .watch(projectControllerProvider)
                .projectConstraints
                .getAll(),
            createNew: () {
              ref.read(projectControllerProvider.notifier).resetBuffers();
              showDialog(
                context: context,
                builder: (context) => StatefulBuilder(
                  builder: (context, setState) =>
                      ProjectConstraintDialog(setState: setState),
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
