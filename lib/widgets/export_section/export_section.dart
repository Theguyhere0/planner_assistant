import 'package:flutter/material.dart';

import '../common/page_section.dart';
import 'cards/export_plan_card.dart';
import 'cards/export_project_card.dart';

/// The section for exporting plans or the project.
class ExportSection extends StatelessWidget {
  const ExportSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageSection(
      'Export',
      icon: Icons.upload_rounded,
      content: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            ExportPlanCard(),
            ExportProjectCard(),
            Spacer(),
          ],
        ),
      ],
    );
  }
}
