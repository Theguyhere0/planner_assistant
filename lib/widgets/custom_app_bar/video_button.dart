import 'package:flutter/material.dart';

import 'custom_icon_button.dart';

/// A button to redirect users to a video for a full tutorial if they want one.
class VideoButton extends StatelessWidget {
  const VideoButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CustomIconButton(
      icon: Icons.ondemand_video_rounded,
      tooltip: 'Watch the tutorial',
      onPressed: null, // TODO: Open tutorial video in new tab
    );
  }
}
