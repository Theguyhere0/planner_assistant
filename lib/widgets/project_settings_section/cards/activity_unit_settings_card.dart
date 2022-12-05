import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/card_tiles/list_card_tile.dart';
import '../../common/cards/small_card.dart';
import '../../common/card_tiles/text_field_card_tile.dart';
import '../../../models/project_controller.dart';
import '../dialogs/property_dialog.dart';

/// A card for managing the settings for activity units of the project.
class ActivityUnitSettingsCard extends ConsumerWidget {
  const ActivityUnitSettingsCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void delete(name) {
      ref.read(projectControllerProvider.notifier)
        ..loadBufferedProperty(name)
        ..removeBufferedProperty();
    }

    return SmallCard(
      'Activity Unit Settings',
      infoContent:
          'Describe what activity units represent by customizing the name. Properties provide a way to record specific types of data about each activity unit.',
      content: Column(children: <Widget>[
        // Activity unit name
        TextFieldCardTile(
          'General Name',
          hintText: 'Activity Unit',
          value: ref.watch(projectControllerProvider).activityUnitName,
          onChanged: (newValue) => ref
              .read(projectControllerProvider.notifier)
              .updateActivityUnitName(newValue),
        ),
        // Plural activity unit name
        TextFieldCardTile(
          'Plural Form',
          hintText: ref
              .watch(projectControllerProvider)
              .displayActivityUnitPluralName,
          value: ref.watch(projectControllerProvider).activityUnitPluralName,
          onChanged: (newValue) => ref
              .read(projectControllerProvider.notifier)
              .updateActivityUnitPluralName(newValue),
        ),
        // Properties of activity units
        ListCardTile(
          title: 'Properties',
          type: 'Property',
          dialog: (name) {
            ref
                .read(projectControllerProvider.notifier)
                .loadBufferedProperty(name);
            showDialog(
              context: context,
              builder: (context) => StatefulBuilder(
                builder: (context, setState) => PropertyDialog(
                  setState: setState,
                  delete: delete,
                ),
              ),
            );
          },
          instances: ref.watch(projectControllerProvider).properties.getAll(),
          createNew: () {
            ref.read(projectControllerProvider.notifier).resetBuffers();
            showDialog(
              context: context,
              builder: (context) => StatefulBuilder(
                builder: (context, setState) =>
                    PropertyDialog(setState: setState),
              ),
            );
          },
          delete: delete,
        ),
      ]),
    );
  }
}
