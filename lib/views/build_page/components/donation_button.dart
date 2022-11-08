import 'package:flutter/material.dart';
import 'package:planner_assistant/utils/constants.dart';

class DonationButton extends StatelessWidget {
  const DonationButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const IconButton(
      onPressed: null,
      icon: Icon(Icons.attach_money_rounded),
      iconSize: 45,
      padding: EdgeInsets.only(left: 20),
      color: highlightColor,
      hoverColor: primaryTextColor,
      tooltip: 'Support the developer',
    );
  }
}
