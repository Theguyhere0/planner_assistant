import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/project_controller.dart';
import '../common/cards/small_card.dart';
import '../common/card_tiles/text_field_card_tile.dart';
import '../common/card_tiles/list_card_tile.dart';
import 'create_label_dialog.dart';
import 'edit_label_dialog.dart';

/// A card for managing the settings for time units of the project.
class TimeUnitSettingsCard extends ConsumerWidget {
  const TimeUnitSettingsCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void delete(String name) {
      ref.read(projectControllerProvider.notifier)
        ..loadBufferedLabel(name)
        ..removeBufferedLabel();
    }

    return SmallCard(
      'Time Unit Settings',
      infoContent:
          'Set how time units behave in this project. Labels provide a descriptor for time units (ex. Monday, Spring 2022). All settings are optional or have default values.',
      content: Column(children: <Widget>[
        TextFieldCardTile(
          'Name',
          hintText: 'Time Unit',
          value: ref.watch(projectControllerProvider).timeUnitName,
          onChanged: (newValue) => ref
              .read(projectControllerProvider.notifier)
              .updateTimeUnitName(newValue),
        ),
        TextFieldCardTile(
          'Plural Form',
          hintText:
              ref.watch(projectControllerProvider).displayTimeUnitPluralName,
          value: ref.watch(projectControllerProvider).timeUnitPluralName,
          onChanged: (newValue) => ref
              .read(projectControllerProvider.notifier)
              .updateTimeUnitPluralName(newValue),
        ),
        ListCardTile(
          title: 'Labels',
          dialog: (name) {
            ref
                .read(projectControllerProvider.notifier)
                .loadBufferedLabel(name);
            showDialog(
              context: context,
              builder: (BuildContext context) => StatefulBuilder(
                builder: (context, setState) => EditLabelDialog(
                  setState: setState,
                  delete: delete,
                ),
              ),
            );
          },
          instances: ref.watch(projectControllerProvider).labels.getAll(),
          createNew: () {
            ref.read(projectControllerProvider.notifier).resetBuffers();
            showDialog(
              context: context,
              builder: (context) => StatefulBuilder(
                builder: (context, setState) =>
                    CreateLabelDialog(setState: setState),
              ),
            );
          },
          delete: delete,
        ),
      ]),
    );
  }
}
