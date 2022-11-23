import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/card_tiles/button_card_tile.dart';
import '../common/card_tiles/dropdown_card_tile.dart';
import '../common/card_tiles/list_card_tile.dart';
import '../common/cards/small_card.dart';
import '../common/card_tiles/text_field_card_tile.dart';
import '../../models/project_controller.dart';
import '../common/dialogs/card_dialog.dart';

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
          cardDialogContent: const Text('test'),
          instances:
              ref.watch(projectControllerProvider).propertyDefinitions.when(
                    data: (data) => data,
                    error: ((error, stackTrace) => []),
                    loading: (() => []),
                  ),
          createNew: () {
            ref.read(projectControllerProvider.notifier).resetBuffers();
            showDialog(
              context: context,
              builder: (context) => StatefulBuilder(
                builder: (context, setState) {
                  bool valid = ref
                      .read(projectControllerProvider.notifier)
                      .validateBufferedPropertyDefinition();
                  return CardDialog(
                    title:
                        'Property: ${ref.watch(projectControllerProvider).bufferedPropertyDefinition.name}',
                    content: Column(
                      children: <Widget>[
                        TextFieldCardTile(
                          'Property Name',
                          hintText: 'Enter a unique name',
                          value: ref
                              .watch(projectControllerProvider)
                              .bufferedPropertyDefinition
                              .name,
                          onChanged: (newValue) => setState(() {
                            ref
                                .read(projectControllerProvider.notifier)
                                .updateBufferedPropertyDefinition(
                                    updatedName: newValue);
                          }),
                          validator: (value) {
                            if (valid) {
                              return null;
                            } else {
                              return 'Property name must exist and be unique';
                            }
                          },
                        ),
                        const DropdownCardTile('Type'),
                        ButtonCardTile(
                          'Save',
                          icon: Icons.save_alt_rounded,
                          onPressed: valid
                              ? () {
                                  ref
                                      .read(projectControllerProvider.notifier)
                                      .saveBufferedPropertyDefinition();
                                  Navigator.pop(context);
                                }
                              : null,
                        )
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ]),
    );
  }
}
