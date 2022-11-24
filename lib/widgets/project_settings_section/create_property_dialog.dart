import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/project_controller.dart';
import '../common/card_tiles/button_card_tile.dart';
import '../common/card_tiles/dropdown_card_tile.dart';
import '../common/card_tiles/text_field_card_tile.dart';
import '../common/dialogs/card_dialog.dart';

class CreatePropertyDialog extends ConsumerWidget {
  const CreatePropertyDialog({
    Key? key,
    required this.setState,
  }) : super(key: key);

  /// The state setter to pass in order to update this dialog properly.
  final void Function(void Function()) setState;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool valid = ref
        .read(projectControllerProvider.notifier)
        .validateBufferedPropertyDefinition();

    return CardDialog(
      title:
          'Property: ${ref.watch(projectControllerProvider).bufferedProperty.name}',
      content: Column(
        children: <Widget>[
          TextFieldCardTile(
            'Property Name',
            hintText: 'Enter a unique name',
            value: ref.watch(projectControllerProvider).bufferedProperty.name,
            onChanged: (newValue) => setState(() {
              ref
                  .read(projectControllerProvider.notifier)
                  .updateBufferedPropertyDefinition(newValue);
            }),
            validator: (value) {
              if (valid) {
                return null;
              } else {
                return 'Property name cannot be blank';
              }
            },
          ),
          const DropdownCardTile('Type'),
          ButtonCardTile(
            'Save',
            icon: Icons.save_alt_rounded,
            onPressed: valid
                ? () {
                    ref
                        .read(projectControllerProvider.notifier)
                        .saveBufferedPropertyDefinition();
                    Navigator.pop(context);
                  }
                : null,
          )
        ],
      ),
    );
  }
}
