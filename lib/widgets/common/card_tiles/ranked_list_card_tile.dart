import 'package:flutter/material.dart';

import '../../../models/database.dart';
import '../../../utils/constants.dart';
import '../list_tiles/creation_list_tile.dart';
import '../list_tiles/ranked_list_tile.dart';

/// A tile for custom cards with a modifiable ranked list.
class RankedListCardTile extends StatefulWidget {
  /// Creates a card tile with a modifiable ranked list.
  const RankedListCardTile({
    Key? key,
    this.title,
    required this.type,
    required this.dialog,
    required this.instances,
    required this.onReorder,
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

  /// All the instances that need to be displayed by this ranked list card tile.
  final List<RankedData> instances;

  /// A callback handling reordering of elements.
  final void Function(int, int) onReorder;

  /// The function to call when creating a new instance.
  final void Function() createNew;

  /// The function to call to delete an instance.
  final void Function(String) delete;

  @override
  State<RankedListCardTile> createState() => _RankedListCardTileState();
}

class _RankedListCardTileState extends State<RankedListCardTile> {
  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    widget.instances.sort(((a, b) => a.rank!.compareTo(b.rank!)));

    return widget.title == null
        ?
        // Expanded variant
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Column(
              children: [
                LimitedBox(
                  maxHeight: 250,
                  child: Card(
                    elevation: 0,
                    margin: const EdgeInsets.only(top: 3),
                    child: Scrollbar(
                      thumbVisibility: true,
                      controller: scrollController,
                      child: ReorderableListView.builder(
                          itemCount: widget.instances.length,
                          shrinkWrap: true,
                          scrollController: scrollController,
                          buildDefaultDragHandles: false,
                          onReorder: widget.onReorder,
                          itemBuilder: (context, index) {
                            return RankedListTile(
                              widget.instances[index].dataName,
                              key: Key(widget.instances[index].dataName),
                              type: widget.type,
                              index: index,
                              height: 35,
                              dialog: widget.dialog,
                              delete: widget.delete,
                            );
                          }),
                    ),
                  ),
                ),
                CreationListTile(
                  onClick: widget.createNew,
                )
              ],
            ),
          )
        // Embedded variant
        : ListTile(
            horizontalTitleGap: titleGap,
            leading: Container(
              width: cardTileTitleWidth,
              alignment: widget.instances.isEmpty
                  ? Alignment.centerRight
                  : Alignment.topRight,
              padding: widget.instances.isEmpty
                  ? const EdgeInsets.only(top: 2)
                  : const EdgeInsets.all(0),
              child: Text(
                widget.title!,
                textAlign: TextAlign.right,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Column(
                children: [
                  LimitedBox(
                    maxHeight: 150,
                    child: Card(
                      elevation: 0,
                      margin: const EdgeInsets.only(top: 3),
                      child: Scrollbar(
                        thumbVisibility: true,
                        controller: scrollController,
                        child: ReorderableListView.builder(
                            itemCount: widget.instances.length,
                            shrinkWrap: true,
                            scrollController: scrollController,
                            onReorder: widget.onReorder,
                            itemBuilder: (context, index) {
                              return RankedListTile(
                                widget.instances[index].dataName,
                                key: Key(widget.instances[index].dataName),
                                type: widget.type,
                                index: index,
                                height: 35,
                                dialog: widget.dialog,
                                delete: widget.delete,
                              );
                            }),
                      ),
                    ),
                  ),
                  CreationListTile(
                    onClick: widget.createNew,
                  ),
                ],
              ),
            ),
          );
  }
}
