import 'package:flutter/material.dart';

import '../common/page_section.dart';
import 'cards/dashboard_card.dart';
import 'cards/plan_generator_card.dart';
import 'cards/plan_editor_card.dart';

/// The section for creating plans of a project.
class PlanningSection extends StatelessWidget {
  const PlanningSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageSection(
      'Planning',
      icon: Icons.view_timeline_outlined,
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
