import 'package:flutter/material.dart';

import '../common/page_section.dart';

class PlanOptimizationSection extends StatelessWidget {
  const PlanOptimizationSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const PageSection(
      'Planning',
      icon: Icons.view_timeline_rounded,
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
