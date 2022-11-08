import 'package:flutter/material.dart';
import 'package:planner_assistant/utils/constants.dart';

class VideoButton extends StatelessWidget {
  const VideoButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const IconButton(
      onPressed: null,
      icon: Icon(Icons.ondemand_video_rounded),
      iconSize: 45,
      padding: EdgeInsets.symmetric(horizontal: 20),
      color: highlightColor,
      hoverColor: primaryTextColor,
      tooltip: 'Video tutorial',
    );
  }
}
