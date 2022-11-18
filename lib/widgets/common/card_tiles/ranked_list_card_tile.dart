import 'package:flutter/material.dart';

import '../../../utils/constants.dart';
import '../list_tiles/creation_list_tile.dart';
import '../list_tiles/ranked_list_tile.dart';

/// A tile for custom cards with a modifiable ranked list.
class RankedListCardTile extends StatefulWidget {
  /// Creates a card tile with a modifiable ranked list.
  const RankedListCardTile({Key? key}) : super(key: key);

  @override
  State<RankedListCardTile> createState() => _RankedListCardTileState();
}

class _RankedListCardTileState extends State<RankedListCardTile> {
  final List<Widget> _items = const <Widget>[
    RankedListTile(
      'test',
      key: Key('1'),
      type: 'Property',
    ),
    RankedListTile(
      'test',
      key: Key('2'),
      type: 'Property',
    ),
    RankedListTile(
      'test',
      key: Key('3'),
      type: 'Property',
    ),
    RankedListTile(
      'test',
      key: Key('4'),
      type: 'Property',
    ),
    RankedListTile(
      'test',
      key: Key('5'),
      type: 'Property',
    ),
    RankedListTile(
      'test',
      key: Key('6'),
      type: 'Property',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: SizedBox(
        height: 290,
        child: Card(
          elevation: 0,
          child: ReorderableListView(
            itemExtent: 35,
            onReorder: (int oldIndex, int newIndex) {
              setState(() {
                if (oldIndex < newIndex) {
                  newIndex--;
                }
                // final Widget item = _items.removeAt(oldIndex);
                // _items.insert(newIndex, item);
              });
            },
            footer: const CreationListTile(key: Key('7')),
            children: _items,
          ),
        ),
      ),
    );
  }
}
