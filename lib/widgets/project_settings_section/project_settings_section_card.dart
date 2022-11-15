import 'package:flutter/material.dart';

import '../common/page_section.dart';
import 'activity_unit_settings_card.dart';
import 'import_projects_card.dart';
import 'time_unit_settings.dart';

/// The section for managing project settings.
class ProjectSettingsSection extends StatelessWidget {
  const ProjectSettingsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageSection(
      'Project Settings',
      icon: Icons.settings_rounded,
      content: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            ActivityUnitSettingsCard(),
            TimeUnitSettingsCard(),
            ImportProjectsCard(),
          ],
        ),
      ],
    );
  }
}
