import 'package:flutter/material.dart';

import '../common/page_section.dart';

class ProjectElementsSection extends StatelessWidget {
  const ProjectElementsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const PageSection(
      'Project Elements',
      icon: Icons.list_alt_rounded,
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
