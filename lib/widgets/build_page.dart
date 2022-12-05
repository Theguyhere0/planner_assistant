import 'package:flutter/material.dart';

import '../utils/constants.dart';
import 'custom_app_bar/custom_app_bar.dart';
import 'export_section/export_section.dart';
import 'planning_section/planning_section.dart';
import 'project_elements_section/project_elements_section.dart';
import 'project_settings_section/project_settings_section.dart';

/// This is the primary page for the app.
class BuildPage extends StatelessWidget {
  /// Creates the primary functional page.
  const BuildPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();

    // Make sure the page is scrollable
    return Scrollbar(
      thumbVisibility: true,
      controller: scrollController,
      child: SingleChildScrollView(
        controller: scrollController,
        child: SafeArea(
          // Bottom side shouldn't matter if it gets cut off
          bottom: false,
          // Provide page margin on all sides
          minimum: const EdgeInsets.symmetric(
            horizontal: pageHorizontalPadding - defaultPadding * 2,
            vertical: pageVerticalPadding,
          ),
          // Break up the page into rows
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              CustomAppBar(),
              ProjectSettingsSection(),
              ProjectElementsSection(),
              PlanningSection(),
              ExportSection(),
            ],
          ),
        ),
      ),
    );
  }
}
