import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/project_controller.dart';
import '../../models/property.dart';
import '../../models/property_type.dart';
import '../common/card_tiles/double_button_card_tile.dart';
import '../common/card_tiles/dropdown_card_tile.dart';
import '../common/card_tiles/text_field_card_tile.dart';
import '../common/card_tiles/toggle_card_tile.dart';
import '../common/dialogs/card_dialog.dart';
import '../common/dialogs/delete_dialog.dart';

/// A popup for modifying a [Property].
class EditPropertyDialog extends ConsumerWidget {
  const EditPropertyDialog({
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
    Property property = ref.watch(projectControllerProvider).bufferedProperty;

    return CardDialog(
      title: 'Property: ${property.name}',
      content: Column(
        children: <Widget>[
          // Property name
          TextFieldCardTile(
            'Property Name',
            hintText: 'Enter the name',
            value: property.name,
            onChanged: (newValue) => setState(() {
              ref
                  .read(projectControllerProvider.notifier)
                  .updateBufferedProperty(updatedName: newValue);
            }),
            validator: (value) {
              if (value!.trim().isNotEmpty) {
                return null;
              } else {
                return 'Property name cannot be blank';
              }
            },
          ),
          // Property type
          DropdownCardTile(
            'Type',
            hintText: 'Select an option',
            options: PropertyType.values.map((e) => e.value).toList(),
            value: property.type?.value,
            onChanged: (newValue) => setState(() {
              ref
                  .read(projectControllerProvider.notifier)
                  .updateBufferedProperty(updatedType: newValue);
            }),
          ),
          // Required toggle
          ToggleCardTile(
            'Required',
            offOption: 'No',
            onOption: 'Yes',
            value: property.mandatory,
            onChanged: (newValue) => setState(() {
              ref
                  .read(projectControllerProvider.notifier)
                  .updateBufferedProperty(updatedMandatory: newValue);
            }),
          ),
          // Save or delete
          DoubleButtonCardTile(
            firstLabel: 'Save',
            secondLabel: 'Delete',
            firstIcon: Icons.save_alt_rounded,
            secondIcon: Icons.delete_outline_rounded,
            firstOnPressed: ref
                    .read(projectControllerProvider.notifier)
                    .validateBufferedProperty()
                ? () {
                    ref
                        .read(projectControllerProvider.notifier)
                        .saveBufferedProperty();
                    Navigator.pop(context);
                  }
                : null,
            secondOnPressed: () {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (BuildContext context) => DeleteDialog(
                  title: 'Delete Property: ${property.name}?',
                  delete: () => delete(property.name),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
