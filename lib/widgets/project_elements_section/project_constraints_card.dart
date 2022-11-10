import 'package:flutter/material.dart';

import '../common/small_card.dart';

class ProjectConstraintsCard extends StatelessWidget {
  const ProjectConstraintsCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SmallCard(
      'Project Constraints',
      infoContent: 'Add constraints that apply to the entire project.',
      content: Column(children: const <Widget>[]),
    );
  }
}
