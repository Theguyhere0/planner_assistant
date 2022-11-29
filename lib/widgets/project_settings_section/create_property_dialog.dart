import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/project_controller.dart';
import '../../models/property.dart';
import '../../models/property_type.dart';
import '../common/card_tiles/button_card_tile.dart';
import '../common/card_tiles/dropdown_card_tile.dart';
import '../common/card_tiles/text_field_card_tile.dart';
import '../common/dialogs/card_dialog.dart';

/// A popup for creating a new [Property].
class CreatePropertyDialog extends ConsumerWidget {
  const CreatePropertyDialog({
    Key? key,
    required this.setState,
  }) : super(key: key);

  /// The state setter to pass in order to update this dialog properly.
  final void Function(void Function()) setState;

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
            autofocus: true,
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
          // Save
          ButtonCardTile(
            'Save',
            icon: Icons.save_alt_rounded,
            onPressed: ref
                    .read(projectControllerProvider.notifier)
                    .validateBufferedProperty()
                ? () {
                    ref
                        .read(projectControllerProvider.notifier)
                        .saveBufferedProperty();
                    Navigator.pop(context);
                  }
                : null,
          )
        ],
      ),
    );
  }
}
