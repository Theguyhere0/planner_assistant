import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/activity_constraint.dart';
import '../../../models/constraint_type.dart';
import '../../../models/project_constraint.dart';
import '../../../models/project_controller.dart';
import '../../../models/property.dart';
import '../../../models/property_data.dart';
import '../../../models/property_type.dart';
import '../../../theme/palette.dart';
import '../../common/card_tiles/button_card_tile.dart';
import '../../common/card_tiles/double_button_card_tile.dart';
import '../../common/card_tiles/dropdown_card_tile.dart';
import '../../common/card_tiles/integer_field_card_tile.dart';
import '../../common/card_tiles/property_card_tile.dart';
import '../../common/card_tiles/text_field_card_tile.dart';
import '../../common/card_tiles/toggle_card_tile.dart';
import '../../common/dialogs/card_dialog.dart';
import '../../common/dialogs/delete_dialog.dart';

/// A popup for modifying a [ProjectConstraint].
class ActivityConstraintDialog extends ConsumerWidget {
  const ActivityConstraintDialog({
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
    final activityConstraint =
        ref.watch(projectControllerProvider).bufferedActivityConstraint;
    final modifiedName = activityConstraint.dataName.replaceFirst('Time Units',
        ref.watch(projectControllerProvider).displayTimeUnitPluralName);
    final property = activityConstraint.threshold?.property;
    final propertyOptions = ref
        .watch(projectControllerProvider)
        .properties
        .getAll()
        .where((e) =>
            (e.type == PropertyType.integer ||
                e.type == PropertyType.decimal) &&
            e.mandatory)
        .map((e) => e.name)
        .toList();
    propertyOptions
        .add(ref.watch(projectControllerProvider).displayTimeUnitPluralName);

    return CardDialog(
      title: 'Activity Constraint: $modifiedName',
      content: Column(
        children: <Widget>[
          // Activity constraint name
          TextFieldCardTile(
            'Name',
            hintText: modifiedName,
            value: activityConstraint.name,
            autofocus: delete == null,
            onChanged: (newValue) => setState(() {
              ref
                  .read(projectControllerProvider.notifier)
                  .updateBufferedActivityConstraint(updatedName: newValue);
            }),
            validator: (value) {
              if (value != null &&
                  !ref
                      .watch(projectControllerProvider)
                      .bufferedActivityUnit
                      .constraints
                      .validateUniqueness(ActivityConstraint(name: value))) {
                return 'Activity constraint name must be unique';
              } else {
                return null;
              }
            },
          ),
          // Activity constraint property
          DropdownCardTile(
            'Property',
            hintText: 'Select an option',
            options: propertyOptions,
            value: property?.name ??
                ref.watch(projectControllerProvider).displayTimeUnitPluralName,
            onChanged: (newValue) => setState(() {
              // Check for an actual difference
              if ((property?.name ??
                      ref
                          .watch(projectControllerProvider)
                          .displayTimeUnitPluralName) ==
                  newValue) {
                return;
              }

              Property? baseProperty = ref
                  .watch(projectControllerProvider)
                  .properties
                  .searchEntry((property) => property.name == newValue);
              if (baseProperty == null) {
                ref
                    .read(projectControllerProvider.notifier)
                    .updateBufferedActivityConstraint(
                        updatedBackupThreshold: 0);
              } else {
                ref
                    .read(projectControllerProvider.notifier)
                    .updateBufferedActivityConstraint(
                        updatedThreshold: PropertyData(
                      property: baseProperty,
                      parent: activityConstraint,
                      intData: 0,
                      doubleData: 0,
                    ));
              }
            }),
          ),
          // Activity constraint threshold value
          property == null
              ? IntegerFieldCardTile(
                  ref
                      .watch(projectControllerProvider)
                      .displayTimeUnitPluralName,
                  value: activityConstraint.backupThreshold,
                  onChanged: (newValue) => setState(() {
                    ref
                        .read(projectControllerProvider.notifier)
                        .updateBufferedActivityConstraint(
                            updatedBackupThreshold:
                                int.tryParse(newValue) ?? 0);
                  }),
                  validator: (value) {
                    if (value != null && value.startsWith('-')) {
                      return 'Positive';
                    } else {
                      return null;
                    }
                  },
                )
              : PropertyCardTile(
                  property: property,
                  data: activityConstraint.threshold!,
                  onChanged: (newValue) => setState(() {
                    ref
                        .read(projectControllerProvider.notifier)
                        .updateBufferedActivityConstraint(
                            updatedThreshold: newValue);
                  }),
                ),
          // Activity constraint type
          DropdownCardTile(
            'Type',
            hintText: 'Select an option',
            options: ConstraintType.values.map((e) => e.value).toList(),
            value: activityConstraint.type.value,
            onChanged: (newValue) => setState(() {
              ref
                  .read(projectControllerProvider.notifier)
                  .updateBufferedActivityConstraint(updatedType: newValue);
            }),
          ),
          // Whether the activity constraint is global or not
          ToggleCardTile(
            'Scope',
            offOption: 'Restricted',
            onOption: 'Global',
            value: activityConstraint.global,
            onChanged: (newValue) => ref
                .read(projectControllerProvider.notifier)
                .updateBufferedActivityConstraint(updatedGlobal: newValue),
          ),
          // Activity constraint period, only visible if not global
          Visibility(
            visible: !activityConstraint.global,
            child: DropdownCardTile(
              'Constraint Period',
              hintText: 'Select an option',
              options: ref
                  .watch(projectControllerProvider)
                  .timePeriods
                  .getAll()
                  .map((e) => e.name)
                  .toList(),
              value: activityConstraint.period?.name,
              onChanged: (newValue) => setState(() {
                ref
                    .read(projectControllerProvider.notifier)
                    .updateBufferedProjectConstraint(updatedPeriod: newValue);
              }),
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
                          .validateBufferedActivityConstraint()
                      ? () {
                          // If the name was default, set actual name to default value
                          ref
                              .read(projectControllerProvider.notifier)
                              .updateBufferedActivityConstraint(
                                  updatedName: modifiedName);

                          ref
                              .read(projectControllerProvider.notifier)
                              .saveBufferedActivityConstraint();
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
                          .validateBufferedActivityConstraint()
                      ? () {
                          // If the name was default, set actual name to default value
                          ref
                              .read(projectControllerProvider.notifier)
                              .updateBufferedActivityConstraint(
                                  updatedName: modifiedName);

                          ref
                              .read(projectControllerProvider.notifier)
                              .saveBufferedActivityConstraint();
                          Navigator.pop(context);
                        }
                      : null,
                  secondOnPressed: () {
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => DeleteDialog(
                        title:
                            'Delete Activity Constraint: ${activityConstraint.dataName}?',
                        delete: () => delete!(activityConstraint.dataName),
                      ),
                    );
                  },
                ),
        ],
      ),
    );
  }
}
