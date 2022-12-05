import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/criterion.dart';
import '../../../models/project_controller.dart';
import '../../../models/property_type.dart';
import '../../../theme/palette.dart';
import '../../common/card_tiles/button_card_tile.dart';
import '../../common/card_tiles/double_button_card_tile.dart';
import '../../common/card_tiles/dropdown_card_tile.dart';
import '../../common/card_tiles/text_card_tile.dart';
import '../../common/card_tiles/text_field_card_tile.dart';
import '../../common/card_tiles/toggle_card_tile.dart';
import '../../common/dialogs/card_dialog.dart';
import '../../common/dialogs/delete_dialog.dart';

/// A popup for modifying a [Criterion].
class CriterionDialog extends ConsumerWidget {
  const CriterionDialog({
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
    final criterion = ref.watch(projectControllerProvider).bufferedCriterion;
    final modifiedName = criterion.dataName.replaceFirst('Time Units',
        ref.watch(projectControllerProvider).displayTimeUnitPluralName);
    final propertyOptions = ref
        .watch(projectControllerProvider)
        .properties
        .getAll()
        .where((e) =>
            e.mandatory &&
            (e.type == PropertyType.integer || e.type == PropertyType.decimal))
        .map((e) => e.name)
        .toList();
    propertyOptions
        .add(ref.watch(projectControllerProvider).displayTimeUnitPluralName);

    return CardDialog(
      title: 'Project Criterion: $modifiedName',
      content: Column(
        children: <Widget>[
          // Criterion name
          TextFieldCardTile(
            'Name',
            hintText: modifiedName,
            value: criterion.name,
            autofocus: delete == null,
            onChanged: (newValue) => setState(() {
              ref
                  .read(projectControllerProvider.notifier)
                  .updateBufferedCriterion(updatedName: newValue);
            }),
            validator: (value) {
              if (value != null &&
                  !ref
                      .watch(projectControllerProvider)
                      .criteria
                      .validateUniqueness(Criterion(name: value))) {
                return 'Project criterion name must be unique';
              } else {
                return null;
              }
            },
          ),
          // Criterion property
          DropdownCardTile(
            'Property',
            hintText: 'Select an option',
            options: propertyOptions,
            value: criterion.property?.name ??
                ref.watch(projectControllerProvider).displayTimeUnitPluralName,
            onChanged: (newValue) => setState(() {
              // Check for an actual difference
              if ((criterion.property?.name ??
                      ref
                          .watch(projectControllerProvider)
                          .displayTimeUnitPluralName) ==
                  newValue) {
                return;
              }
              ref
                  .read(projectControllerProvider.notifier)
                  .updateBufferedCriterion(
                    updatedProperty: newValue,
                  );
            }),
          ),
          // Criterion maximize or minimize. If for time units, only allow for minimizing.
          criterion.property == null
              ? const TextCardTile(
                  'Minimize',
                  label: 'Goal',
                )
              : ToggleCardTile(
                  'Goal',
                  offOption: 'Minimize',
                  onOption: 'Maximize',
                  value: criterion.maximize,
                  onChanged: (newValue) => ref
                      .read(projectControllerProvider.notifier)
                      .updateBufferedCriterion(updatedMaximize: newValue),
                ),
          // Whether the criterion is global or not
          ToggleCardTile(
            'Scope',
            offOption: 'Restricted',
            onOption: 'Global',
            value: criterion.global,
            onChanged: (newValue) => ref
                .read(projectControllerProvider.notifier)
                .updateBufferedCriterion(updatedGlobal: newValue),
          ),
          // Criterion period, only visible if not global
          Visibility(
            visible: !criterion.global,
            child: DropdownCardTile(
              'Constraint Period',
              hintText: 'Select an option',
              options: ref
                  .watch(projectControllerProvider)
                  .timePeriods
                  .getAll()
                  .map((e) => e.name)
                  .toList(),
              value: criterion.period?.name,
              onChanged: (newValue) => setState(() {
                ref
                    .read(projectControllerProvider.notifier)
                    .updateBufferedCriterion(updatedPeriod: newValue);
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
                          .validateBufferedCriterion()
                      ? () {
                          // If the name was default, set actual name to default value
                          ref
                              .read(projectControllerProvider.notifier)
                              .updateBufferedCriterion(
                                updatedName: modifiedName,
                                updatedRank: ref
                                        .watch(projectControllerProvider)
                                        .criteria
                                        .getAll()
                                        .length +
                                    1,
                              );

                          ref
                              .read(projectControllerProvider.notifier)
                              .saveBufferedCriterion();
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
                          .validateBufferedCriterion()
                      ? () {
                          // If the name was default, set actual name to default value
                          ref
                              .read(projectControllerProvider.notifier)
                              .updateBufferedCriterion(
                                  updatedName: modifiedName);

                          ref
                              .read(projectControllerProvider.notifier)
                              .saveBufferedCriterion();
                          Navigator.pop(context);
                        }
                      : null,
                  secondOnPressed: () {
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => DeleteDialog(
                        title:
                            'Delete Project Criterion: ${criterion.dataName}?',
                        delete: () => delete!(criterion.dataName),
                      ),
                    );
                  },
                ),
        ],
      ),
    );
  }
}
