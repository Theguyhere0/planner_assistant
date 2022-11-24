import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planner_assistant/widgets/common/card_tiles/toggle_card_tile.dart';

import '../../models/label.dart';
import '../../models/project_controller.dart';
import '../common/card_tiles/button_card_tile.dart';
import '../common/card_tiles/number_field_card_tile.dart';
import '../common/card_tiles/text_field_card_tile.dart';
import '../common/dialogs/card_dialog.dart';

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
          TextFieldCardTile(
            'Label Name',
            hintText: 'Enter a name',
            value: label.name,
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
          NumberFieldCardTile(
            'Duration',
            units:
                ref.read(projectControllerProvider).displayTimeUnitPluralName,
            value: label.duration.toString(),
            onChanged: (newValue) => setState(() {
              ref.read(projectControllerProvider.notifier).updateBufferedLabel(
                  updatedDuration: int.tryParse(newValue) ?? 0);
            }),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Required';
              } else if (int.parse(value) < 1) {
                return 'Nonzero';
              } else {
                return null;
              }
            },
          ),
          NumberFieldCardTile(
            'Start',
            units: ref.read(projectControllerProvider).displayTimeUnitName,
            prefix: true,
            value: label.start.toString(),
            onChanged: (newValue) => setState(() {
              ref.read(projectControllerProvider.notifier).updateBufferedLabel(
                  updatedStart: int.tryParse(newValue) ?? 0);
            }),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Required';
              } else if (int.parse(value) < 1) {
                return 'Nonzero';
              } else {
                return null;
              }
            },
          ),
          ToggleCardTile(
            'Periodic?',
            offOption: 'No',
            onOption: 'Yes',
            value: label.period != null,
            onChanged: (newValue) => ref
                .read(projectControllerProvider.notifier)
                .updateBufferedLabel(periodOn: newValue),
          ),
          Visibility(
            visible: label.period != null,
            child: NumberFieldCardTile(
              'Period',
              hintText: '0',
              units:
                  ref.read(projectControllerProvider).displayTimeUnitPluralName,
              value: label.period.toString(),
              onChanged: (newValue) => setState(() {
                ref
                    .read(projectControllerProvider.notifier)
                    .updateBufferedLabel(
                        updatedPeriod: int.tryParse(newValue) ?? 0);
              }),
            ),
          ),
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
