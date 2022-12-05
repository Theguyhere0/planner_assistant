import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/time_period.dart';
import '../../../models/project_controller.dart';
import '../../../theme/palette.dart';
import '../../common/card_tiles/button_card_tile.dart';
import '../../common/card_tiles/double_button_card_tile.dart';
import '../../common/card_tiles/integer_field_card_tile.dart';
import '../../common/card_tiles/text_field_card_tile.dart';
import '../../common/card_tiles/toggle_card_tile.dart';
import '../../common/dialogs/card_dialog.dart';
import '../../common/dialogs/delete_dialog.dart';

/// A popup for modifying a [TimePeriod].
class TimePeriodDialog extends ConsumerWidget {
  const TimePeriodDialog({
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
    TimePeriod period = ref.watch(projectControllerProvider).bufferedTimePeriod;
    return CardDialog(
      title: 'Time Period: ${period.name}',
      content: Column(
        children: <Widget>[
          // Period name
          TextFieldCardTile(
            'Time Period Name',
            hintText: 'Enter the name',
            value: period.name,
            autofocus: delete == null,
            onChanged: (newValue) => setState(() {
              ref
                  .read(projectControllerProvider.notifier)
                  .updateBufferedTimePeriod(updatedName: newValue);
            }),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Time period name cannot be blank';
              } else if (!ref
                  .watch(projectControllerProvider)
                  .timePeriods
                  .validateUniqueness(TimePeriod(name: value))) {
                return 'Time period name must be unique';
              } else {
                return null;
              }
            },
          ),
          // Time period duration
          IntegerFieldCardTile(
            'Duration',
            units:
                ref.read(projectControllerProvider).displayTimeUnitPluralName,
            value: period.duration,
            onChanged: (newValue) => setState(() {
              ref
                  .read(projectControllerProvider.notifier)
                  .updateBufferedTimePeriod(
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
          // Time period start
          IntegerFieldCardTile(
            'Start',
            units: ref.read(projectControllerProvider).displayTimeUnitName,
            prefix: true,
            value: period.start,
            onChanged: (newValue) => setState(() {
              ref
                  .read(projectControllerProvider.notifier)
                  .updateBufferedTimePeriod(
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
          // Whether the time period is periodic or not
          ToggleCardTile(
            'Periodic',
            offOption: 'No',
            onOption: 'Yes',
            value: period.period != null,
            onChanged: (newValue) => ref
                .read(projectControllerProvider.notifier)
                .updateBufferedTimePeriod(periodOn: newValue),
          ),
          // Time period length
          Visibility(
            visible: period.period != null,
            child: IntegerFieldCardTile(
              'Period',
              hintText: '0',
              units:
                  ref.read(projectControllerProvider).displayTimeUnitPluralName,
              value: period.period,
              onChanged: (newValue) => setState(() {
                ref
                    .read(projectControllerProvider.notifier)
                    .updateBufferedTimePeriod(
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
                          .validateBufferedTimePeriod()
                      ? () {
                          ref
                              .read(projectControllerProvider.notifier)
                              .saveBufferedTimePeriod();
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
                          .validateBufferedTimePeriod()
                      ? () {
                          ref
                              .read(projectControllerProvider.notifier)
                              .saveBufferedTimePeriod();
                          Navigator.pop(context);
                        }
                      : null,
                  secondOnPressed: () {
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => DeleteDialog(
                        title: 'Delete Time Period: ${period.name}?',
                        delete: () => delete!(period.name),
                      ),
                    );
                  },
                ),
        ],
      ),
    );
  }
}
