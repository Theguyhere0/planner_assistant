import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
class ProjectConstraintDialog extends ConsumerWidget {
  const ProjectConstraintDialog({
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
    final projectConstraint =
        ref.watch(projectControllerProvider).bufferedProjectConstraint;
    final modifiedName = projectConstraint.dataName.replaceFirst(
        'Activity Units',
        ref.watch(projectControllerProvider).displayActivityUnitPluralName);
    final property = projectConstraint.threshold?.property;
    final propertyOptions = ref
        .watch(projectControllerProvider)
        .properties
        .getAll()
        .where((e) => e.mandatory)
        .map((e) => e.name)
        .toList();
    propertyOptions.add(
        ref.watch(projectControllerProvider).displayActivityUnitPluralName);
    final allowedTypes = ConstraintType.values.map((e) => e.value).toList();
    if (projectConstraint.threshold != null &&
        (projectConstraint.threshold!.property.type! == PropertyType.boolean ||
            projectConstraint.threshold!.property.type! ==
                PropertyType.string)) {
      allowedTypes.clear();
      allowedTypes.add(ConstraintType.equal.value);
      allowedTypes.add(ConstraintType.notEqual.value);
    }

    return CardDialog(
      title: 'Project Constraint: $modifiedName',
      content: Column(
        children: <Widget>[
          // Project constraint name
          TextFieldCardTile(
            'Name',
            hintText: modifiedName,
            value: projectConstraint.name,
            autofocus: delete == null,
            onChanged: (newValue) => setState(() {
              ref
                  .read(projectControllerProvider.notifier)
                  .updateBufferedProjectConstraint(updatedName: newValue);
            }),
            validator: (value) {
              if (value != null &&
                  !ref
                      .watch(projectControllerProvider)
                      .projectConstraints
                      .validateUniqueness(ProjectConstraint(name: value))) {
                return 'Project constraint name must be unique';
              } else {
                return null;
              }
            },
          ),
          // Project constraint property
          DropdownCardTile(
            'Property',
            hintText: 'Select an option',
            options: propertyOptions,
            value: property?.name ??
                ref
                    .watch(projectControllerProvider)
                    .displayActivityUnitPluralName,
            onChanged: (newValue) => setState(() {
              // Check for an actual difference
              if ((property?.name ??
                      ref
                          .watch(projectControllerProvider)
                          .displayActivityUnitPluralName) ==
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
                    .updateBufferedProjectConstraint(
                      updatedBackupThreshold: 0,
                      updatedType: ConstraintType.equal.value,
                    );
              } else {
                ref
                    .read(projectControllerProvider.notifier)
                    .updateBufferedProjectConstraint(
                      updatedThreshold: PropertyData(
                          property: baseProperty, parent: projectConstraint),
                      updatedType: ConstraintType.equal.value,
                    );
              }
            }),
          ),
          // Project constraint threshold value
          property == null
              ? IntegerFieldCardTile(
                  ref
                      .watch(projectControllerProvider)
                      .displayActivityUnitPluralName,
                  value: projectConstraint.backupThreshold,
                  onChanged: (newValue) => setState(() {
                    ref
                        .read(projectControllerProvider.notifier)
                        .updateBufferedProjectConstraint(
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
                  data: projectConstraint.threshold!,
                  onChanged: (newValue) => setState(() {
                    ref
                        .read(projectControllerProvider.notifier)
                        .updateBufferedProjectConstraint(
                            updatedThreshold: newValue);
                  }),
                ),
          // Project constraint type
          DropdownCardTile(
            'Type',
            hintText: 'Select an option',
            options: allowedTypes,
            value: projectConstraint.type.value,
            onChanged: (newValue) => setState(() {
              ref
                  .read(projectControllerProvider.notifier)
                  .updateBufferedProjectConstraint(updatedType: newValue);
            }),
          ),
          // Whether the project constraint is global or not
          ToggleCardTile(
            'Scope',
            offOption: 'Restricted',
            onOption: 'Global',
            value: projectConstraint.global,
            onChanged: (newValue) => ref
                .read(projectControllerProvider.notifier)
                .updateBufferedProjectConstraint(updatedGlobal: newValue),
          ),
          // Project constraint label, only visible if not global
          Visibility(
            visible: !projectConstraint.global,
            child: DropdownCardTile(
              'Constraint Period',
              hintText: 'Select an option',
              options: ref
                  .watch(projectControllerProvider)
                  .labels
                  .getAll()
                  .map((e) => e.name)
                  .toList(),
              value: projectConstraint.label?.name,
              onChanged: (newValue) => setState(() {
                ref
                    .read(projectControllerProvider.notifier)
                    .updateBufferedProjectConstraint(updatedLabel: newValue);
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
                          .validateBufferedProjectConstraint()
                      ? () {
                          // If the name was default, set actual name to default value
                          ref
                              .read(projectControllerProvider.notifier)
                              .updateBufferedProjectConstraint(
                                  updatedName: modifiedName);

                          ref
                              .read(projectControllerProvider.notifier)
                              .saveBufferedProjectConstraint();
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
                          .validateBufferedProjectConstraint()
                      ? () {
                          // If the name was default, set actual name to default value
                          ref
                              .read(projectControllerProvider.notifier)
                              .updateBufferedProjectConstraint(
                                  updatedName: modifiedName);

                          ref
                              .read(projectControllerProvider.notifier)
                              .saveBufferedProjectConstraint();
                          Navigator.pop(context);
                        }
                      : null,
                  secondOnPressed: () {
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => DeleteDialog(
                        title:
                            'Delete Project Constraint: ${projectConstraint.dataName}?',
                        delete: () => delete!(projectConstraint.dataName),
                      ),
                    );
                  },
                ),
        ],
      ),
    );
  }
}
