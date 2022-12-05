import 'package:flutter/material.dart';

import '../common/page_section.dart';
import 'cards/activity_units_card.dart';
import 'cards/project_constraints_card.dart';
import 'cards/project_criteria_card.dart';

/// The section for managing project elements.
class ProjectElementsSection extends StatelessWidget {
  const ProjectElementsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageSection(
      'Project Elements',
      icon: Icons.list_alt_rounded,
      content: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            ActivityUnitsCard(),
            ProjectConstraintsCard(),
            ProjectCriteriaCard(),
          ],
        ),
      ],
    );
  }
}
