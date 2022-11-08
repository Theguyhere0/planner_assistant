import 'package:planner_assistant/utils/constants.dart';
import 'package:planner_assistant/views/build_page/components/custom_app_bar.dart';
import 'package:flutter/material.dart';

class BuildPage extends StatelessWidget {
  const BuildPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // Bottom side shouldn't matter if it gets cut off
      bottom: false,
      // Provide page margin on all sides that matter
      minimum: const EdgeInsets.only(
        left: pageSidePadding,
        right: pageSidePadding,
        top: pageTopPadding,
      ),
      // Break up the page into rows
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: const CustomAppBar(),
            margin: const EdgeInsets.all(defaultPadding),
          ),
        ],
      ),
    );
  }
}
