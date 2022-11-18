import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/card_tiles/list_card_tile.dart';
import '../common/cards/small_card.dart';
import '../common/card_tiles/text_field_card_tile.dart';
import '../../models/project_controller.dart';

/// A card for managing the settings for activity units of the project.
class ActivityUnitSettingsCard extends ConsumerWidget {
  const ActivityUnitSettingsCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = ref.watch(projectControllerProvider).activityUnitName;

    return SmallCard(
      'Activity Unit Settings',
      infoContent:
          'Set how activity units behave in this project. All settings are optional or have default values.',
      content: Column(children: <Widget>[
        TextFieldCardTile(
          'General Name',
          hintText: 'Activity Unit',
          value: name,
          onChanged: (newValue) => ref
              .read(projectControllerProvider.notifier)
              .updateActivityUnitName(newValue),
        ),
        TextFieldCardTile(
          'Plural Form',
          hintText: '${name.isEmpty ? 'Activity Unit' : name}s',
          value: ref.watch(projectControllerProvider).activityUnitPluralName,
          onChanged: (newValue) => ref
              .read(projectControllerProvider.notifier)
              .updateActivityUnitPluralName(newValue),
        ),
        const ListCardTile(title: 'Properties'),
      ]),
    );
  }
}
