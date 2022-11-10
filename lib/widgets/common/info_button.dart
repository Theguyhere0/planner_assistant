import 'package:flutter/material.dart';

import '../../theme/palette.dart';
import '../../utils/constants.dart';
import '../../utils/responsive.dart';

class InfoButton extends StatefulWidget {
  const InfoButton({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  final String title;
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
          builder: (BuildContext context) => AlertDialog(
            title: Text(widget.title),
            content: Container(
              child: Text(widget.content),
              width: Responsive.isDesktop(context)
                  ? 750
                  : (Responsive.isTablet(context) ? 600 : 400),
            ),
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
