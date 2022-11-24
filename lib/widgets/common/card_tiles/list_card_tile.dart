import 'package:flutter/material.dart';

import '../../../models/data.dart';
import '../../../utils/constants.dart';
import '../list_tiles/creation_list_tile.dart';
import '../list_tiles/instance_list_tile.dart';

/// A tile for custom cards with a modifiable list.
class ListCardTile extends StatelessWidget {
  /// Creates a card tile with a modifiable list.
  const ListCardTile({
    Key? key,
    this.title,
    required this.dialog,
    required this.instances,
    required this.createNew,
    required this.delete,
  }) : super(key: key);

  /// A possible descriptor for the list.
  ///
  /// A null title will result in an expanded variant that is meant to take up an entire [SmallCard].
  final String? title;

  /// A callback for the dialog to display when an instance tile is clicked.
  final Widget Function(void Function(void Function())) dialog;

  /// All the instances that need to be displayed by this list card tile.
  final List<Data> instances;

  /// The function to call when creating a new instance.
  final void Function() createNew;

  /// The function to call to delete an instance.
  final void Function() delete;

  @override
  Widget build(BuildContext context) {
    return title == null
        // Expanded variant
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Column(
              children: <Widget>[
                LimitedBox(
                  maxHeight: 250,
                  child: Card(
                    elevation: 0,
                    child: ListView.builder(
                      itemExtent: 35,
                      itemCount: instances.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return InstanceListTile(
                          instances[index].dataName,
                          type: instances[index].dataType,
                          dialog: dialog,
                          delete: delete,
                        );
                      },
                    ),
                  ),
                ),
                const CreationListTile(
                  onClick: null,
                ),
              ],
            ),
          )
        // Embedded variant
        : ListTile(
            leading: Container(
              width: cardTileTitleWidth,
              alignment: Alignment.topRight,
              child: Text(
                title!,
                textAlign: TextAlign.right,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Column(
                children: <Widget>[
                  LimitedBox(
                    maxHeight: 150,
                    child: Card(
                      elevation: 0,
                      child: ListView.builder(
                        itemExtent: 35,
                        itemCount: instances.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return InstanceListTile(
                            instances[index].dataName,
                            type: instances[index].dataType,
                            dialog: dialog,
                            delete: delete,
                          );
                        },
                      ),
                    ),
                  ),
                  CreationListTile(
                    onClick: createNew,
                  ),
                ],
              ),
            ),
          );
  }
}
