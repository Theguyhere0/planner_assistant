import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planner_assistant/widgets/common/card_tiles/toggle_card_tile.dart';

import '../../models/label.dart';
import '../../models/project_controller.dart';
import '../common/card_tiles/button_card_tile.dart';
import '../common/card_tiles/integer_field_card_tile.dart';
import '../common/card_tiles/text_field_card_tile.dart';
import '../common/dialogs/card_dialog.dart';

/// A popup for creating a new [Label].
class CreateLabelDialog extends ConsumerWidget {
  const CreateLabelDialog({
    Key? key,
    required this.setState,
  }) : super(key: key);

  /// The state setter to pass in order to update this dialog properly.
  final void Function(void Function()) setState;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Label label = ref.watch(projectControllerProvider).bufferedLabel;
    return CardDialog(
      title: 'Label: ${label.name}',
      content: Column(
        children: <Widget>[
          // Label name
          TextFieldCardTile(
            'Label Name',
            hintText: 'Enter the name',
            value: label.name,
            autofocus: true,
            onChanged: (newValue) => setState(() {
              ref
                  .read(projectControllerProvider.notifier)
                  .updateBufferedLabel(updatedName: newValue);
            }),
            validator: (value) {
              if (value!.trim().isNotEmpty) {
                return null;
              } else {
                return 'Label name cannot be blank';
              }
            },
          ),
          // Label duration
          IntegerFieldCardTile(
            'Duration',
            units:
                ref.read(projectControllerProvider).displayTimeUnitPluralName,
            value: label.duration,
            onChanged: (newValue) => setState(() {
              ref.read(projectControllerProvider.notifier).updateBufferedLabel(
                  updatedDuration: int.tryParse(newValue) ?? 0);
            }),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Required';
              } else if (value.startsWith('-')) {
                return 'Positive';
              } else if (int.parse(value) < 1) {
                return 'Nonzero';
              } else {
                return null;
              }
            },
          ),
          // Label start
          IntegerFieldCardTile(
            'Start',
            units: ref.read(projectControllerProvider).displayTimeUnitName,
            prefix: true,
            value: label.start,
            onChanged: (newValue) => setState(() {
              ref.read(projectControllerProvider.notifier).updateBufferedLabel(
                  updatedStart: int.tryParse(newValue) ?? 0);
            }),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Required';
              } else if (value.startsWith('-')) {
                return 'Positive';
              } else if (int.parse(value) < 1) {
                return 'Nonzero';
              } else {
                return null;
              }
            },
          ),
          // Whether label is periodic or not
          ToggleCardTile(
            'Periodic',
            offOption: 'No',
            onOption: 'Yes',
            value: label.period != null,
            onChanged: (newValue) => ref
                .read(projectControllerProvider.notifier)
                .updateBufferedLabel(periodOn: newValue),
          ),
          // Label period
          Visibility(
            visible: label.period != null,
            child: IntegerFieldCardTile(
              'Period',
              hintText: '0',
              units:
                  ref.read(projectControllerProvider).displayTimeUnitPluralName,
              value: label.period,
              onChanged: (newValue) => setState(() {
                ref
                    .read(projectControllerProvider.notifier)
                    .updateBufferedLabel(
                        updatedPeriod: int.tryParse(newValue) ?? 0);
              }),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Required';
                } else if (value.startsWith('-')) {
                  return 'Positive';
                } else if (int.parse(value) < 1) {
                  return 'Nonzero';
                } else {
                  return null;
                }
              },
            ),
          ),
          // Save
          ButtonCardTile(
            'Save',
            icon: Icons.save_alt_rounded,
            onPressed: ref
                    .read(projectControllerProvider.notifier)
                    .validateBufferedLabel()
                ? () {
                    ref
                        .read(projectControllerProvider.notifier)
                        .saveBufferedLabel();
                    Navigator.pop(context);
                  }
                : null,
          )
        ],
      ),
    );
  }
}
