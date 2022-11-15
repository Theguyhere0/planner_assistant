import 'package:flutter/material.dart';

import 'custom_icon_button.dart';

/// A button to redirect users to a video for a full tutorial if they want one.
class VideoButton extends StatelessWidget {
  const VideoButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomIconButton(
      icon: Icons.ondemand_video_rounded,
      tooltip: 'Watch the tutorial',
      onPressed: () {}, // TODO: Open tutorial video in new tab
    );
  }
}
