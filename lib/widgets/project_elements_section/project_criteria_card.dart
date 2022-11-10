import 'package:flutter/material.dart';

import '../common/small_card.dart';

class ProjectCriteriaCard extends StatelessWidget {
  const ProjectCriteriaCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SmallCard(
      'Project Criteria',
      infoContent: 'Add criteria that this project should optimize for.',
      content: Column(children: const <Widget>[]),
    );
  }
}
