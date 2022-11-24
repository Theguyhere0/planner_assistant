import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/project_controller.dart';
import '../common/cards/small_card.dart';
import '../common/card_tiles/list_card_tile.dart';
import '../../utils/constants.dart';

/// A card for managing the constraints of the project.
class ProjectConstraintsCard extends ConsumerWidget {
  const ProjectConstraintsCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SmallCard(
      'Project Constraints',
      infoContent: 'Add constraints that apply to the entire project.',
      content: Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: ListCardTile(
            dialog: (name) => const Text('test'),
            instances:
                ref.watch(projectControllerProvider).projectConstraints.when(
                      data: (data) => data,
                      error: ((error, stackTrace) => []),
                      loading: (() => []),
                    ),
            createNew: () {},
            delete: (name) {},
          ),
        ),
      ]),
    );
  }
}
