import 'package:flutter/material.dart';

import '../common/cards/large_card.dart';

class PlanEditorCard extends StatelessWidget {
  const PlanEditorCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LargeCard(
      'Plan Editor',
      infoContent:
          'Adjust and modify plans to your liking, or create one manually.',
      content: Column(children: const <Widget>[]),
    );
  }
}
