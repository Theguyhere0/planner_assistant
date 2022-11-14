import 'package:flutter/material.dart';

import '../../../utils/constants.dart';
import '../list_tiles/creation_list_tile.dart';
import '../list_tiles/instance_list_tile.dart';

/// A tile for custom cards with a modifiable list.
class ListCardTile extends StatelessWidget {
  /// Creates a card tile with a modifiable list.
  const ListCardTile({Key? key, this.title}) : super(key: key);

  /// A possible descriptor for the list.
  ///
  /// A null title will result in an expanded variant that is meant to take up an entire [SmallCard].
  final String? title;

  @override
  Widget build(BuildContext context) {
    return title == null
        // Expanded variant
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: SizedBox(
              child: Card(
                elevation: 0,
                child: ListView(
                  itemExtent: 35,
                  children: const <Widget>[
                    InstanceListTile(
                      'test',
                      type: 'Property',
                    ),
                    InstanceListTile(
                      'test',
                      type: 'Property',
                    ),
                    InstanceListTile(
                      'test',
                      type: 'Property',
                    ),
                    InstanceListTile(
                      'test',
                      type: 'Property',
                    ),
                    InstanceListTile(
                      'test',
                      type: 'Property',
                    ),
                    InstanceListTile(
                      'test',
                      type: 'Property',
                    ),
                    InstanceListTile(
                      'test',
                      type: 'Property',
                    ),
                    InstanceListTile(
                      'test',
                      type: 'Property',
                    ),
                    CreationListTile(),
                  ],
                ),
              ),
              height: 290,
            ),
          )
        // Embedded variant
        : ListTile(
            leading: Container(
              child: Text(
                title!,
                textAlign: TextAlign.right,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              width: cardTileTitleWidth,
              alignment: Alignment.topRight,
            ),
            title: Padding(
              padding: const EdgeInsets.only(top: 2),
              child: SizedBox(
                child: Card(
                  elevation: 0,
                  child: ListView(
                    itemExtent: 35,
                    children: const <Widget>[
                      InstanceListTile(
                        'test',
                        type: 'Property',
                      ),
                      InstanceListTile(
                        'test',
                        type: 'Property',
                      ),
                      InstanceListTile(
                        'test',
                        type: 'Property',
                      ),
                      InstanceListTile(
                        'test',
                        type: 'Property',
                      ),
                      InstanceListTile(
                        'test',
                        type: 'Property',
                      ),
                      InstanceListTile(
                        'test',
                        type: 'Property',
                      ),
                      CreationListTile(),
                    ],
                  ),
                ),
                height: 185,
              ),
            ),
          );
  }
}
