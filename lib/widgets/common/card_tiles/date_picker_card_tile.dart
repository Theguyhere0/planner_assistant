import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../utils/constants.dart';

/// A tile for custom cards with for picking dates.
class DatePickerCardTile extends StatelessWidget {
  /// Creates a card tile with for picking dates.
  const DatePickerCardTile(
    this.title, {
    Key? key,
    required this.value,
    this.onChanged,
  }) : super(key: key);

  /// What the date is for.
  final String title;

  /// What value the date picker holds.
  final DateTime value;

  /// What should happen when changes occur.
  final void Function(DateTime?)? onChanged;

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
              onChanged!(await showDatePicker(
                context: context,
                initialDate: value,
                firstDate: DateTime(0),
                lastDate: DateTime(2151),
              ));
            }
          },
          child: Text(DateFormat.yMMMMd().format(value)),
        ),
      ),
    );
  }
}
