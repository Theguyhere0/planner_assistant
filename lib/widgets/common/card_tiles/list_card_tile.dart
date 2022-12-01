import 'package:flutter/material.dart';

import '../../../models/database.dart';
import '../../../utils/constants.dart';
import '../list_tiles/creation_list_tile.dart';
import '../list_tiles/instance_list_tile.dart';

/// A tile for custom cards with a modifiable list.
class ListCardTile extends StatelessWidget {
  /// Creates a card tile with a modifiable list.
  const ListCardTile({
    Key? key,
    this.title,
    required this.type,
    required this.dialog,
    required this.instances,
    required this.createNew,
    required this.delete,
  }) : super(key: key);

  /// A possible descriptor for the list.
  ///
  /// A null title will result in an expanded variant that is meant to take up an entire [SmallCard].
  final String? title;

  /// The type of data that is being listed.
  final String type;

  /// A callback for the dialog to display when an instance tile is clicked.
  final void Function(String) dialog;

  /// All the instances that need to be displayed by this list card tile.
  final List<Data> instances;

  /// The function to call when creating a new instance.
  final void Function() createNew;

  /// The function to call to delete an instance.
  final void Function(String) delete;

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();

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
                    margin: const EdgeInsets.only(top: 3),
                    child: Scrollbar(
                      thumbVisibility: true,
                      controller: scrollController,
                      child: ListView.builder(
                        itemExtent: 35,
                        itemCount: instances.length,
                        shrinkWrap: true,
                        controller: scrollController,
                        itemBuilder: (context, index) {
                          return InstanceListTile(
                            instances[index].dataName,
                            type: type,
                            dialog: dialog,
                            delete: delete,
                          );
                        },
                      ),
                    ),
                  ),
                ),
                CreationListTile(
                  onClick: createNew,
                ),
              ],
            ),
          )
        // Embedded variant
        : ListTile(
            horizontalTitleGap: titleGap,
            leading: Container(
              width: cardTileTitleWidth,
              alignment: instances.isEmpty
                  ? Alignment.centerRight
                  : Alignment.topRight,
              padding: instances.isEmpty
                  ? const EdgeInsets.only(top: 2)
                  : const EdgeInsets.all(0),
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
                      margin: const EdgeInsets.only(top: 3),
                      child: Scrollbar(
                        thumbVisibility: true,
                        controller: scrollController,
                        child: ListView.builder(
                          itemExtent: 35,
                          itemCount: instances.length,
                          shrinkWrap: true,
                          controller: scrollController,
                          itemBuilder: (context, index) {
                            return InstanceListTile(
                              instances[index].dataName,
                              type: type,
                              dialog: dialog,
                              delete: delete,
                            );
                          },
                        ),
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
