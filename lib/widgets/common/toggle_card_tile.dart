import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class ToggleCardTile extends StatelessWidget {
  const ToggleCardTile(
    this.title, {
    required this.leftToggleOption,
    required this.rightToggleOption,
    Key? key,
  }) : super(key: key);

  final String title;
  final String leftToggleOption;
  final String rightToggleOption;

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
        alignment: Alignment.centerRight,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(leftToggleOption),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Switch(
              value: false,
              onChanged: null,
            ),
          ),
          Text(rightToggleOption),
        ],
      ),
    );
  }
}
