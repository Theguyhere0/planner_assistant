import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/dependency_type.dart';
import '../../../models/project_controller.dart';
import '../../../models/dependency.dart';
import '../../../theme/palette.dart';
import '../../common/card_tiles/button_card_tile.dart';
import '../../common/card_tiles/double_button_card_tile.dart';
import '../../common/card_tiles/dropdown_card_tile.dart';
import '../../common/card_tiles/text_field_card_tile.dart';
import '../../common/dialogs/card_dialog.dart';
import '../../common/dialogs/delete_dialog.dart';

/// A popup for modifying a [Dependency].
class DependencyDialog extends ConsumerWidget {
  const DependencyDialog({
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
    final dependency = ref.watch(projectControllerProvider).bufferedDependency;

    return CardDialog(
      title: 'Dependency: ${dependency.dataName}',
      content: Column(
        children: <Widget>[
          // Dependency name
          TextFieldCardTile(
            'Name',
            hintText: dependency.dataName,
            value: dependency.name,
            autofocus: delete == null,
            onChanged: (newValue) => setState(() {
              ref
                  .read(projectControllerProvider.notifier)
                  .updateBufferedDependency(updatedName: newValue);
            }),
            validator: (value) {
              if (value != null &&
                  !ref
                      .watch(projectControllerProvider)
                      .bufferedActivityUnit
                      .dependencies
                      .validateUniqueness(Dependency(name: value))) {
                return 'Dependency name must be unique';
              } else {
                return null;
              }
            },
          ),
          // Dependency predecessor
          DropdownCardTile(
            'Predeces- sor',
            hintText: 'Select an option',
            options: ref
                .watch(projectControllerProvider)
                .activityUnits
                .getAll()
                .where((e) => e != dependency.parent)
                .map((e) => e.dataName)
                .toList(),
            value: dependency.predecessor?.dataName,
            onChanged: (newValue) => setState(() {
              // Check for an actual difference
              if (dependency.dataName == newValue) {
                return;
              }

              ref
                  .read(projectControllerProvider.notifier)
                  .updateBufferedDependency(updatedPredecessor: newValue);
            }),
          ),
          // Dependency type
          DropdownCardTile(
            'Type',
            hintText: 'Select an option',
            options: DependencyType.values.map((e) => e.value).toList(),
            value: dependency.type.value,
            onChanged: (newValue) => setState(() {
              ref
                  .read(projectControllerProvider.notifier)
                  .updateBufferedDependency(updatedType: newValue);
            }),
          ),
          delete == null
              ?
              // Save
              ButtonCardTile(
                  'Save',
                  icon: Icons.save_alt_rounded,
                  onPressed: ref
                          .read(projectControllerProvider.notifier)
                          .validateBufferedDependency()
                      ? () {
                          // If the name was default, set actual name to default value
                          ref
                              .read(projectControllerProvider.notifier)
                              .updateBufferedDependency(
                                  updatedName: dependency.dataName);

                          ref
                              .read(projectControllerProvider.notifier)
                              .saveBufferedDependency();
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
                              .updateBufferedDependency(
                                  updatedName: dependency.dataName);

                          ref
                              .read(projectControllerProvider.notifier)
                              .saveBufferedDependency();
                          Navigator.pop(context);
                        }
                      : null,
                  secondOnPressed: () {
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => DeleteDialog(
                        title: 'Delete Dependency: ${dependency.dataName}?',
                        delete: () => delete!(dependency.dataName),
                      ),
                    );
                  },
                ),
        ],
      ),
    );
  }
}
