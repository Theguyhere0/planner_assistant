import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/activity_unit.dart';
import '../../../models/project_controller.dart';
import '../../../models/property_data.dart';
import '../../../theme/palette.dart';
import '../../common/card_tiles/button_card_tile.dart';
import '../../common/card_tiles/double_button_card_tile.dart';
import '../../common/card_tiles/list_card_tile.dart';
import '../../common/card_tiles/integer_field_card_tile.dart';
import '../../common/card_tiles/property_card_tile.dart';
import '../../common/card_tiles/text_field_card_tile.dart';
import '../../common/card_tiles/toggle_card_tile.dart';
import '../../common/dialogs/card_dialog.dart';
import '../../common/dialogs/delete_dialog.dart';
import 'activity_constraint_dialog.dart';

/// A popup for modifying an [ActivityUnit].
class ActivityUnitDialog extends ConsumerWidget {
  const ActivityUnitDialog({
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
    ActivityUnit activityUnit =
        ref.watch(projectControllerProvider).bufferedActivityUnit;
    void deleteActivityConstraint(name) {
      ref.read(projectControllerProvider.notifier)
        ..loadBufferedActivityConstraint(name)
        ..removeBufferedActivityConstraint();
    }

    List<Widget> children = [
      // Activity unit name
      TextFieldCardTile(
        'Name',
        hintText: 'Enter the name',
        value: activityUnit.name,
        autofocus: delete == null,
        onChanged: (newValue) => setState(() {
          ref
              .read(projectControllerProvider.notifier)
              .updateBufferedActivityUnit(updatedName: newValue);
        }),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Name cannot be blank';
          } else if (!ref
              .watch(projectControllerProvider)
              .activityUnits
              .validateUniqueness(ActivityUnit(name: value))) {
            return 'Name must be unique';
          } else {
            return null;
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
        .map((e) => PropertyCardTile(
              property: e,
              data: activityUnit.data[e] ??
                  PropertyData(property: e, parent: activityUnit),
              onChanged: (newValue) => setState(() {
                ref
                    .read(projectControllerProvider.notifier)
                    .updateBufferedActivityUnit(updatedPropertyData: newValue);
              }),
            )));

    // Activity Constraints
    children.add(ListCardTile(
      title: 'Activity Constraints',
      type: 'Activity Constraint',
      dialog: (name) {
        ref
            .read(projectControllerProvider.notifier)
            .loadBufferedActivityConstraint(name);
        showDialog(
          context: context,
          builder: (context) => StatefulBuilder(
            builder: (context, setState) => ActivityConstraintDialog(
              setState: setState,
              delete: deleteActivityConstraint,
            ),
          ),
        );
      },
      instances: activityUnit.constraints.getAll(),
      createNew: () {
        ref
            .read(projectControllerProvider.notifier)
            .resetActivityConstraintBuffer();
        showDialog(
          context: context,
          builder: (context) => StatefulBuilder(
            builder: (context, setState) =>
                ActivityConstraintDialog(setState: setState),
          ),
        );
      },
      delete: deleteActivityConstraint,
    ));

    // Save
    if (delete == null) {
      children.add(ButtonCardTile(
        'Save',
        icon: Icons.save_alt_rounded,
        onPressed: ref
                .read(projectControllerProvider.notifier)
                .validateBufferedActivityUnit()
            ? () {
                ref
                    .read(projectControllerProvider.notifier)
                    .saveBufferedActivityUnit();
                Navigator.pop(context);
              }
            : null,
      ));
    } else {
      children.add(DoubleButtonCardTile(
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
              delete: () => delete!(activityUnit.name),
            ),
          );
        },
      ));
    }

    return CardDialog(
      title:
          '${ref.watch(projectControllerProvider).displayActivityUnitName}: ${activityUnit.name}',
      content: Column(
        children: children,
      ),
    );
  }
}
