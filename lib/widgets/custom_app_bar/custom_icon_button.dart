import 'package:flutter/material.dart';

import '../../theme/palette.dart';
import '../../utils/constants.dart';

/// A class to standardize icon buttons for this app.
class CustomIconButton extends StatefulWidget {
  /// Creates a standard icon button customized for the UI of this app.
  const CustomIconButton({
    Key? key,
    required this.icon,
    required this.tooltip,
    this.onPressed,
  }) : super(key: key);

  /// A pictorial representation of the button's function.
  final IconData icon;

  /// Some information about what this button does.
  final String tooltip;

  /// What this button does when pressed.
  final void Function()? onPressed;

  @override
  State<CustomIconButton> createState() => _CustomIconButton();
}

class _CustomIconButton extends State<CustomIconButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding * 2),
      child: MouseRegion(
        child: IconButton(
          onPressed: widget.onPressed,
          mouseCursor: widget.onPressed == null
              ? SystemMouseCursors.forbidden
              : SystemMouseCursors.click,
          color: _hover ? Palette.highlight : Palette.suppressed,
          icon: Icon(widget.icon),
          iconSize: appBarButtonSize,
          padding: const EdgeInsets.all(0),
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
      ),
    );
  }
}
