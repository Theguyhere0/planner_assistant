import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/label.dart';
import '../../models/project_controller.dart';
import '../common/card_tiles/double_button_card_tile.dart';
import '../common/card_tiles/number_field_card_tile.dart';
import '../common/card_tiles/text_field_card_tile.dart';
import '../common/card_tiles/toggle_card_tile.dart';
import '../common/dialogs/card_dialog.dart';
import '../common/dialogs/delete_dialog.dart';

class EditLabelDialog extends ConsumerWidget {
  const EditLabelDialog({
    Key? key,
    required this.setState,
    required this.delete,
  }) : super(key: key);

  /// The state setter to pass in order to update this dialog properly.
  final void Function(void Function()) setState;

  /// The function to call to perform the delete.
  final void Function(String) delete;

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
            value: ref.watch(projectControllerProvider).bufferedLabel.period !=
                null,
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
          DoubleButtonCardTile(
            firstLabel: 'Save',
            secondLabel: 'Delete',
            firstIcon: Icons.save_alt_rounded,
            secondIcon: Icons.delete_outline_rounded,
            firstOnPressed: ref
                    .read(projectControllerProvider.notifier)
                    .validateBufferedLabel()
                ? () {
                    ref
                        .read(projectControllerProvider.notifier)
                        .saveBufferedLabel();
                    Navigator.pop(context);
                  }
                : null,
            secondOnPressed: () {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (BuildContext context) => DeleteDialog(
                  title: 'Delete ${label.dataType}: ${label.name}?',
                  delete: () => delete(label.name),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
