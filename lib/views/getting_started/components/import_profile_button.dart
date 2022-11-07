import 'package:flutter/material.dart';

import '../../../utils/constants.dart';
import '../../../responsive.dart';

class ImportProfileButton extends StatelessWidget {
  const ImportProfileButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: null,
      icon: Icon(Icons.file_download),
      label: Text('Import Profile'),
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(
          horizontal: defaultPadding * 1.5,
          vertical: defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
        ),
        backgroundColor: primaryColor,
      ),
    );
  }
}
