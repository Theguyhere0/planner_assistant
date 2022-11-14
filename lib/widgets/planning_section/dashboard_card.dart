import 'package:flutter/material.dart';

import '../common/cards/medium_card.dart';

/// A card for displaying important metrics about a plan of the project.
class DashboardCard extends StatelessWidget {
  const DashboardCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MediumCard(
      'Dashboard',
      infoContent:
          'Check how well your plans fit your criteria and constraints.',
      content: Column(children: const <Widget>[]),
    );
  }
}
