import 'package:course_schedule_maker/constants.dart';
import 'package:flutter/material.dart';

import '../../../responsive.dart';

class NewProfileButton extends StatelessWidget {
  const NewProfileButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: null,
      icon: Icon(Icons.add),
      label: Text('New Profile'),
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(
          horizontal: defaultPadding * 1.5,
          vertical: defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
        ),
      ),
    );
  }
}
