import 'package:flutter/material.dart';

import '../../common/cards/small_card.dart';

/// A card for exporting plans of the project in a neat format.
class ExportPlanCard extends StatelessWidget {
  const ExportPlanCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SmallCard(
      'Save a Plan',
      infoContent:
          'Save important plans in a variety of formats. Data files for plans cannot be exported on their own and must be exported with project settings in "Save the Project."',
      content: Column(children: const <Widget>[]),
    );
  }
}
