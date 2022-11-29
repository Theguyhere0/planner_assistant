import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/activity_unit.dart';
import '../../models/label.dart';
import '../../models/project_controller.dart';
import '../../models/property.dart';
import '../common/card_tiles/double_button_card_tile.dart';
import '../common/card_tiles/list_card_tile.dart';
import '../common/card_tiles/integer_field_card_tile.dart';
import '../common/card_tiles/text_field_card_tile.dart';
import '../common/card_tiles/toggle_card_tile.dart';
import '../common/dialogs/card_dialog.dart';
import '../common/dialogs/delete_dialog.dart';

/// A popup for modifying an [Label].
class EditActivityUnitDialog extends ConsumerWidget {
  const EditActivityUnitDialog({
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
    ActivityUnit activityUnit =
        ref.watch(projectControllerProvider).bufferedActivityUnit;
    List<Widget> children = [
      // Activity unit name
      TextFieldCardTile(
        'Name',
        hintText: 'Enter the name',
        value: activityUnit.name,
        autofocus: true,
        onChanged: (newValue) => setState(() {
          ref
              .read(projectControllerProvider.notifier)
              .updateBufferedActivityUnit(updatedName: newValue);
        }),
        validator: (value) {
          if (value!.trim().isNotEmpty) {
            return null;
          } else {
            return 'Name cannot be blank';
          }
        },
      ),
      // Activity unit duration
      IntegerFieldCardTile(
        'Duration',
        units: ref.read(projectControllerProvider).displayTimeUnitPluralName,
        value: activityUnit.duration,
        onChanged: (newValue) => setState(() {
          ref
              .read(projectControllerProvider.notifier)
              .updateBufferedActivityUnit(
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
      // Whether activity unit is unique or not
      ToggleCardTile(
        'Unique',
        offOption: 'No',
        onOption: 'Yes',
        value: activityUnit.unique,
        onChanged: (newValue) => ref
            .read(projectControllerProvider.notifier)
            .updateBufferedActivityUnit(updatedUnique: newValue),
      ),
    ];

    // Properties
    children.addAll(ref
        .watch(projectControllerProvider)
        .properties
        .getAll()
        .map((e) => Property.toWidget(
            e,
            activityUnit,
            (newValue) => setState(() {
                  ref
                      .read(projectControllerProvider.notifier)
                      .updateBufferedActivityUnit(
                          updatedPropertyData: newValue);
                }))));

    // Activity Constraints
    children.add(ListCardTile(
      title: 'Activity Constraints',
      type: 'Activity Constraint',
      dialog: (name) => const Text('Placeholder'),
      instances:
          ref.watch(projectControllerProvider).bufferedActivityUnit.constraints,
      createNew: () {},
      delete: (name) {},
    ));

    // Save
    children.add(DoubleButtonCardTile(
      firstLabel: 'Save',
      secondLabel: 'Delete',
      firstIcon: Icons.save_alt_rounded,
      secondIcon: Icons.delete_outline_rounded,
      firstOnPressed: ref
              .read(projectControllerProvider.notifier)
              .validateBufferedActivityUnit()
          ? () {
              ref
                  .read(projectControllerProvider.notifier)
                  .saveBufferedActivityUnit();
              Navigator.pop(context);
            }
          : null,
      secondOnPressed: () {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (BuildContext context) => DeleteDialog(
            title:
                'Delete ${ref.watch(projectControllerProvider).displayActivityUnitName}: ${activityUnit.name}?',
            delete: () => delete(activityUnit.name),
          ),
        );
      },
    ));

    return CardDialog(
      title:
          '${ref.watch(projectControllerProvider).displayActivityUnitName}: ${activityUnit.name}',
      content: Column(
        children: children,
      ),
    );
  }
}
