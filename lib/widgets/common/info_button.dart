import 'package:flutter/material.dart';

import '../../theme/palette.dart';
import '../../utils/constants.dart';
import 'dialogs/info_dialog.dart';

/// A class to standardize information buttons across the app.
class InfoButton extends StatefulWidget {
  /// Creates a standard information button customized for the UI of this app.
  const InfoButton({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  /// What the information is for.
  final String title;

  /// The extra information to be displayed.
  final String content;

  @override
  State<InfoButton> createState() => _InfoButton();
}

class _InfoButton extends State<InfoButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      child: IconButton(
        onPressed: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => InfoDialog(
            title: widget.title,
            content: widget.content,
          ),
        ),
        mouseCursor: SystemMouseCursors.click,
        color: _hover ? Palette.highlight : Palette.suppressed,
        icon: const Icon(Icons.info_outline_rounded),
        iconSize: infoIconSize,
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        tooltip: 'Press for more info',
      ),
      onHover: (event) {
        setState(() {
          _hover = true;
        });
      },
      onExit: (event) {
        setState(() {
          _hover = false;
        });
      },
    );
  }
}
