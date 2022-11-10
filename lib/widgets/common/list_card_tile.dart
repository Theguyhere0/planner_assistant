import 'package:flutter/material.dart';

import '../../theme/palette.dart';
import '../../utils/constants.dart';

class ListCardTile extends StatelessWidget {
  const ListCardTile(this.title, {Key? key}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        child: Text(
          title,
          textAlign: TextAlign.right,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        width: cardTileTitleWidth,
        alignment: Alignment.topRight,
      ),
      title: Padding(
        padding: const EdgeInsets.only(top: defaultPadding),
        child: ConstrainedBox(
          child: ListView(
            itemExtent: 35,
            children: <Widget>[
              ListTile(
                title: Container(
                  child: Text('test'),
                  alignment: Alignment.topLeft,
                ),
                tileColor: Palette.card,
                hoverColor: Palette.focus,
                onTap: () {},
              ),
              ListTile(
                title: Text('test'),
                tileColor: Palette.card,
                hoverColor: Palette.focus,
                onTap: () {},
              ),
              ListTile(
                title: Text('test'),
                tileColor: Palette.card,
                hoverColor: Palette.focus,
                onTap: () {},
              ),
              ListTile(
                title: Text('test'),
                tileColor: Palette.card,
                hoverColor: Palette.focus,
                onTap: () {},
              ),
              ListTile(
                title: Text('test'),
                tileColor: Palette.card,
                hoverColor: Palette.focus,
                onTap: () {},
              ),
              ListTile(
                title: Text('test'),
                tileColor: Palette.card,
                hoverColor: Palette.focus,
                onTap: () {},
              ),
              ListTile(
                title: Text('test'),
                tileColor: Palette.card,
                hoverColor: Palette.focus,
                onTap: () {},
              ),
            ],
            shrinkWrap: true,
          ),
          constraints: BoxConstraints.loose(const Size(50, 200)),
        ),
      ),
    );
  }
}
