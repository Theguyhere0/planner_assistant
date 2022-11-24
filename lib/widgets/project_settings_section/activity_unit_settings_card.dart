import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/card_tiles/list_card_tile.dart';
import '../common/cards/small_card.dart';
import '../common/card_tiles/text_field_card_tile.dart';
import '../../models/project_controller.dart';
import 'create_property_dialog.dart';
import 'edit_property_dialog.dart';

/// A card for managing the settings for activity units of the project.
class ActivityUnitSettingsCard extends ConsumerWidget {
  const ActivityUnitSettingsCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SmallCard(
      'Activity Unit Settings',
      infoContent:
          'Set how activity units behave in this project. All settings are optional or have default values.',
      content: Column(children: <Widget>[
        TextFieldCardTile(
          'General Name',
          hintText: 'Activity Unit',
          value: ref.watch(projectControllerProvider).activityUnitName,
          onChanged: (newValue) => ref
              .read(projectControllerProvider.notifier)
              .updateActivityUnitName(newValue),
        ),
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
        ListCardTile(
          title: 'Properties',
          dialog: (setState) => EditPropertyDialog(setState: setState),
          instances: ref.watch(projectControllerProvider).properties.getAll(),
          createNew: () {
            ref.read(projectControllerProvider.notifier).resetBuffers();
            showDialog(
              context: context,
              builder: (context) => StatefulBuilder(
                builder: (context, setState) => CreatePropertyDialog(
                  setState: setState,
                ),
              ),
            );
          },
          delete: () {
            ref
                .read(projectControllerProvider.notifier)
                .removeBufferedPropertyDefinition();
          },
        ),
      ]),
    );
  }
}
