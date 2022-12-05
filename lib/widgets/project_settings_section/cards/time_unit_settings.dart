import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/project_controller.dart';
import '../../common/cards/small_card.dart';
import '../../common/card_tiles/text_field_card_tile.dart';
import '../../common/card_tiles/list_card_tile.dart';
import '../dialogs/time_period_dialog.dart';

/// A card for managing the settings for time units of the project.
class TimeUnitSettingsCard extends ConsumerWidget {
  const TimeUnitSettingsCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void delete(String name) {
      ref.read(projectControllerProvider.notifier)
        ..loadBufferedTimePeriod(name)
        ..removeBufferedTimePeriod();
    }

    return SmallCard(
      'Time Unit Settings',
      infoContent:
          'Describe what time units represent by customizing the name. Time periods provide a an extra way to group and organize time units (ex. Monday, Spring 2025).',
      content: Column(children: <Widget>[
        // Time unit name
        TextFieldCardTile(
          'Name',
          hintText: 'Time Unit',
          value: ref.watch(projectControllerProvider).timeUnitName,
          onChanged: (newValue) => ref
              .read(projectControllerProvider.notifier)
              .updateTimeUnitName(newValue),
        ),
        // Plural time unit name
        TextFieldCardTile(
          'Plural Form',
          hintText:
              ref.watch(projectControllerProvider).displayTimeUnitPluralName,
          value: ref.watch(projectControllerProvider).timeUnitPluralName,
          onChanged: (newValue) => ref
              .read(projectControllerProvider.notifier)
              .updateTimeUnitPluralName(newValue),
        ),
        // Labels for time units
        ListCardTile(
          title: 'Time Periods',
          type: 'Time Period',
          dialog: (name) {
            ref
                .read(projectControllerProvider.notifier)
                .loadBufferedTimePeriod(name);
            showDialog(
              context: context,
              builder: (BuildContext context) => StatefulBuilder(
                builder: (context, setState) => TimePeriodDialog(
                  setState: setState,
                  delete: delete,
                ),
              ),
            );
          },
          instances: ref.watch(projectControllerProvider).timePeriods.getAll(),
          createNew: () {
            ref.read(projectControllerProvider.notifier).resetBuffers();
            showDialog(
              context: context,
              builder: (context) => StatefulBuilder(
                builder: (context, setState) =>
                    TimePeriodDialog(setState: setState),
              ),
            );
          },
          delete: delete,
        ),
      ]),
    );
  }
}
