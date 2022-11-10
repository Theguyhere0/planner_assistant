import 'package:flutter/material.dart';

import '../../theme/palette.dart';
import '../../utils/constants.dart';

class CustomIconButton extends StatefulWidget {
  const CustomIconButton({
    Key? key,
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  }) : super(key: key);

  final IconData icon;
  final String tooltip;
  final void Function() onPressed;

  @override
  State<CustomIconButton> createState() => _CustomIconButton();
}

class _CustomIconButton extends State<CustomIconButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      child: IconButton(
        onPressed: widget.onPressed,
        mouseCursor: SystemMouseCursors.click,
        color: _hover ? Palette.highlight : Palette.suppressed,
        icon: Icon(widget.icon),
        iconSize: appBarButtonSize,
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding * 2),
        tooltip: widget.tooltip,
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
