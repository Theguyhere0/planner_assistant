import 'package:flutter/material.dart';

import '../../../../utils/constants.dart';

class DonationButton extends StatelessWidget {
  const DonationButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const IconButton(
      onPressed: null,
      icon: Icon(Icons.attach_money_rounded),
      iconSize: appBarButtonSize,
      padding: EdgeInsets.only(left: defaultPadding * 2),
      tooltip: 'Support the developer',
    );
  }
}
