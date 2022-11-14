import 'package:flutter/material.dart';

import '../../../utils/responsive.dart';

class InfoDialog extends StatelessWidget {
  const InfoDialog({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: SizedBox(
        child: Text(content),
        width: Responsive.isDesktop(context)
            ? 750
            : (Responsive.isTablet(context) ? 600 : 400),
      ),
    );
  }
}
