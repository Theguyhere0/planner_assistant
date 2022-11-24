import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/project_controller.dart';
import '../common/card_tiles/double_button_card_tile.dart';
import '../common/card_tiles/dropdown_card_tile.dart';
import '../common/card_tiles/text_field_card_tile.dart';
import '../common/dialogs/card_dialog.dart';

class EditPropertyDialog extends ConsumerWidget {
  const EditPropertyDialog({
    Key? key,
    required this.setState,
  }) : super(key: key);

  /// The state setter to pass in order to update this dialog properly.
  final void Function(void Function()) setState;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String name = ref.watch(projectControllerProvider).bufferedProperty.name;
    bool valid = ref
        .read(projectControllerProvider.notifier)
        .validateBufferedPropertyDefinition();

    return CardDialog(
      title: 'Property: $name',
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
          DoubleButtonCardTile(
            firstLabel: 'Save',
            secondLabel: 'Delete',
            firstIcon: Icons.save_alt_rounded,
            secondIcon: Icons.delete_outline_rounded,
            firstOnPressed: valid
                ? () {
                    ref
                        .read(projectControllerProvider.notifier)
                        .saveBufferedPropertyDefinition();
                    Navigator.pop(context);
                  }
                : null,
            secondOnPressed: () {
              ref
                  .read(projectControllerProvider.notifier)
                  .removeBufferedPropertyDefinition();
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
