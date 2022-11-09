import 'package:flutter/material.dart';

import '../common/small_card.dart';

class ImportProjectsCard extends StatelessWidget {
  const ImportProjectsCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SmallCard(
      'Import Projects',
      content: Column(children: const <Widget>[]),
    );
  }
}
