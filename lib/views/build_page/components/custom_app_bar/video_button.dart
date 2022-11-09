import 'package:flutter/material.dart';

import '../../../../utils/constants.dart';

class VideoButton extends StatelessWidget {
  const VideoButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const IconButton(
      onPressed: null,
      icon: Icon(Icons.ondemand_video_rounded),
      iconSize: appBarButtonSize,
      padding: EdgeInsets.symmetric(horizontal: defaultPadding * 2),
      tooltip: 'Video tutorial',
    );
  }
}
