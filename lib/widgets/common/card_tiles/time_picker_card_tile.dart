import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

/// A tile for custom cards with for picking time.
class TimePickerCardTile extends StatelessWidget {
  /// Creates a card tile with for picking time.
  const TimePickerCardTile(
    this.title, {
    Key? key,
    required this.value,
    this.onChanged,
  }) : super(key: key);

  /// What the time is for.
  final String title;

  /// What value the time picker holds.
  final TimeOfDay value;

  /// What should happen when changes occur.
  final void Function(TimeOfDay?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
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
        alignment: Alignment.bottomLeft,
        child: TextButton(
          onPressed: () async {
            if (onChanged != null) {
              onChanged!(await showTimePicker(
                context: context,
                initialTime: value,
              ));
            }
          },
          child: Text(value.format(context)),
        ),
      ),
    );
  }
}
