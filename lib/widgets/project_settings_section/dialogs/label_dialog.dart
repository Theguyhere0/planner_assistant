import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/label.dart';
import '../../../models/project_controller.dart';
import '../../../theme/palette.dart';
import '../../common/card_tiles/button_card_tile.dart';
import '../../common/card_tiles/double_button_card_tile.dart';
import '../../common/card_tiles/integer_field_card_tile.dart';
import '../../common/card_tiles/text_field_card_tile.dart';
import '../../common/card_tiles/toggle_card_tile.dart';
import '../../common/dialogs/card_dialog.dart';
import '../../common/dialogs/delete_dialog.dart';

/// A popup for modifying a [Label].
class LabelDialog extends ConsumerWidget {
  const LabelDialog({
    Key? key,
    required this.setState,
    this.delete,
  }) : super(key: key);

  /// The state setter to pass in order to update this dialog properly.
  final void Function(void Function()) setState;

  /// The function to call to perform the delete. If null, indicates initialization.
  final void Function(String)? delete;

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
            autofocus: delete == null,
            onChanged: (newValue) => setState(() {
              ref
                  .read(projectControllerProvider.notifier)
                  .updateBufferedLabel(updatedName: newValue);
            }),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Label name cannot be blank';
              } else if (!ref
                  .watch(projectControllerProvider)
                  .labels
                  .validateUniqueness(Label(name: value))) {
                return 'Label name must be unique';
              } else {
                return null;
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
          delete == null
              ?
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
              :
              // Save or delete
              DoubleButtonCardTile(
                  firstLabel: 'Save',
                  secondLabel: 'Delete',
                  firstIcon: Icons.save_alt_rounded,
                  secondIcon: Icons.delete_outline_rounded,
                  secondColor: MaterialStateProperty.resolveWith<Color?>(
                    (states) {
                      if (states.contains(MaterialState.hovered)) {
                        return Palette.highlight;
                      }
                      return Palette.failure;
                    },
                  ),
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
                        title: 'Delete Label: ${label.name}?',
                        delete: () => delete!(label.name),
                      ),
                    );
                  },
                ),
        ],
      ),
    );
  }
}