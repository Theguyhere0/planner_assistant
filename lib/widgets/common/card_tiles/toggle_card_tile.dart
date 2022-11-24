import 'package:flutter/material.dart';

import '../../../theme/palette.dart';
import '../../../utils/constants.dart';

/// A tile for custom cards with a toggle switch.
class ToggleCardTile extends StatelessWidget {
  /// Creates a card tile with a toggle switch.
  const ToggleCardTile(
    this.title, {
    required this.offOption,
    required this.onOption,
    required this.value,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  /// What the toggle selection is for.
  final String title;

  /// What option is selected when the toggle is switched off.
  final String offOption;

  /// What option is selected when the toggle is switched on.
  final String onOption;

  /// The value of the toggle.
  final bool value;

  /// What should happen when changes occur.
  final void Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: cardTileTitleWidth,
        alignment: Alignment.centerRight,
        child: Text(
          title,
          textAlign: TextAlign.right,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            offOption,
            style: DefaultTextStyle.of(context)
                .style
                .copyWith(color: value ? Palette.suppressed : Palette.standard),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Switch(
              value: value,
              onChanged: onChanged,
            ),
          ),
          Text(
            onOption,
            style: DefaultTextStyle.of(context)
                .style
                .copyWith(color: value ? Palette.standard : Palette.suppressed),
          ),
        ],
      ),
    );
  }
}
