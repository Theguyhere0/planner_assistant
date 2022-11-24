import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/project_controller.dart';
import '../../../theme/palette.dart';
import '../buttons/delete_button.dart';

/// A tile for custom lists for editing an element.
class InstanceListTile extends ConsumerWidget {
  /// Creates a tile for displaying an element.
  const InstanceListTile(
    this.name, {
    Key? key,
    required this.type,
    required this.dialog,
    required this.delete,
  }) : super(key: key);

  /// The name of the element.
  final String name;

  /// The type of element being displayed.
  final String type;

  /// A callback for the dialog to display when clicked.
  final Widget Function(void Function(void Function())) dialog;

  /// The function to call to delete this instance.
  final void Function() delete;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: Container(
        alignment: Alignment.topLeft,
        child: Text(name),
      ),
      trailing: DeleteButton(
        title: 'Delete $type?',
        delete: () {
          ref
              .read(projectControllerProvider.notifier)
              .loadBufferedProperty(name);
          delete();
        },
      ),
      tileColor: Palette.card,
      hoverColor: Palette.focus,
      onTap: () {
        ref.read(projectControllerProvider.notifier).loadBufferedProperty(name);
        showDialog(
          context: context,
          builder: (BuildContext context) => StatefulBuilder(
            builder: (context, setState) => dialog(setState),
          ),
        );
      },
    );
  }
}
