import 'package:flutter/material.dart';

import '../common/page_section.dart';

class ExportSection extends StatelessWidget {
  const ExportSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const PageSection(
      'Export',
      icon: Icons.upload_rounded,
      content: <Widget>[
        Card(
          elevation: 0,
          child: Center(
            child: Text('test'),
          ),
        ),
      ],
    );
  }
}
