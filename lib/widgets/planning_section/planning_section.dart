import 'package:flutter/material.dart';

import '../common/page_section.dart';
import 'dashboard_card.dart';
import 'plan_generator_card.dart';
import 'plan_editor_card.dart';

class PlanOptimizationSection extends StatelessWidget {
  const PlanOptimizationSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageSection(
      'Planning',
      icon: Icons.view_timeline_rounded,
      content: <Widget>[
        Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                PlanGeneratorCard(),
                DashboardCard(),
              ],
            ),
            const PlanEditorCard(),
          ],
        ),
      ],
    );
  }
}
