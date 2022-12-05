import 'package:flutter/material.dart';

import '../../../theme/palette.dart';
import '../../../utils/constants.dart';

/// A tile for custom cards with a dropdown menu.
class DropdownCardTile extends StatelessWidget {
  /// Creates a card tile with a dropdown menu.
  const DropdownCardTile(
    this.title, {
    Key? key,
    this.hintText,
    this.label = true,
    required this.options,
    required this.value,
    this.onChanged,
  }) : super(key: key);

  /// What the dropdown is for.
  final String title;

  /// Default option or hint for what to input.
  final String? hintText;

  /// Whether the title will display as a label on the left or as the hint inside the dropdown.
  final bool label;

  /// The options available for this dropdown.
  final List<String> options;

  /// What value the dropdown currently holds.
  final String? value;

  /// What should happen when changes occur.
  final void Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return label
        // Title is displayed on the left
        ? ListTile(
            horizontalTitleGap: titleGap,
            leading: Container(
              width: cardTileTitleWidth,
              alignment: Alignment.centerRight,
              child: Text(
                title,
                textAlign: TextAlign.right,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            title: Container(
              alignment: Alignment.centerLeft,
              child: Theme(
                data: Theme.of(context).copyWith(
                  focusColor: Colors.transparent,
                  hoverColor: Palette.focus,
                ),
                child: DropdownButton(
                  value: value,
                  hint: Text(hintText ?? ''),
                  iconEnabledColor: Palette.standard,
                  focusColor: Colors.transparent,
                  borderRadius: BorderRadius.circular(defaultPadding),
                  underline: Container(),
                  menuMaxHeight: 250,
                  items: options.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: defaultPadding),
                        child: Text(value),
                      ),
                    );
                  }).toList(),
                  onChanged: onChanged,
                ),
              ),
            ),
          )
        // Title is displayed as the hint and the dropdown menu is centered
        : ListTile(
            title: Container(
              alignment: Alignment.center,
              child: Theme(
                data: Theme.of(context).copyWith(
                  focusColor: Colors.transparent,
                  hoverColor: Palette.focus,
                ),
                child: DropdownButton(
                  value: value,
                  hint: Text(title),
                  iconEnabledColor: Palette.standard,
                  focusColor: Colors.transparent,
                  borderRadius: BorderRadius.circular(defaultPadding),
                  underline: Container(),
                  menuMaxHeight: 250,
                  items: null,
                  // list.map<DropdownMenuItem<String>>((String value) {
                  //   return DropdownMenuItem<String>(
                  //     value: value,
                  //     child: Padding(
                  //       padding: const EdgeInsets.symmetric(
                  //           horizontal: defaultPadding),
                  //       child: Text(value),
                  //     ),
                  //   );
                  // }).toList(),
                  onChanged: onChanged,
                ),
              ),
            ),
          );
  }
}
