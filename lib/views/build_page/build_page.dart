import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import 'components/custom_app_bar/custom_app_bar.dart';
import 'components/export_section/export_section.dart';
import 'components/planning_section/planning_section.dart';
import 'components/project_elements_section/project_elements_section.dart';
import 'components/project_settings_section/project_settings_section_card.dart';

class BuildPage extends StatelessWidget {
  const BuildPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // Bottom side shouldn't matter if it gets cut off
      bottom: false,
      // Provide page margin on all sides that matter
      minimum: const EdgeInsets.only(
        left: pageSidePadding - defaultPadding * 2,
        right: pageSidePadding - defaultPadding * 2,
        top: pageTopPadding,
      ),
      // Break up the page into rows
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          CustomAppBar(),
          ProjectSettingsSection(),
          ProjectElementsSection(),
          PlanOptimizationSection(),
          ExportSection(),
        ],
      ),
    );
  }
}
