import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Hypertext extends StatefulWidget {
  const Hypertext({
    Key? key,
    required this.hypertext,
    this.prefix,
    this.suffix,
    required this.normalStyle,
    this.hypertextStyle,
    this.underline = false,
    required this.onTap,
  }) : super(key: key);

  /// The special hypertext to display.
  final String hypertext;

  /// An optional normal text to come before the hypertext.
  final String? prefix;

  /// An optional normal text to come after the hypertext.
  final String? suffix;

  /// The text style for normal text, and for the hypertext when not hovered.
  final TextStyle normalStyle;

  /// The text style for when the hypertext is hovered.
  final TextStyle? hypertextStyle;

  /// Whether the hypertext will have an underline. Defaults to false.
  final bool underline;

  /// What the hypertext does when tapped.
  final void Function() onTap;

  @override
  HypertextState createState() => HypertextState();
}

class HypertextState extends State<Hypertext> {
  bool _hover = false;
  late final TextDecoration? _underline =
      widget.underline ? TextDecoration.underline : null;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: widget.prefix,
            style: widget.normalStyle,
          ),
          TextSpan(
            text: widget.hypertext,
            style: _hover
                ? (widget.hypertextStyle ?? widget.normalStyle)
                    .copyWith(decoration: _underline)
                : widget.normalStyle.copyWith(decoration: _underline),
            mouseCursor: SystemMouseCursors.click,
            onEnter: (_) => setState(() => _hover = true),
            onExit: (_) => setState(() => _hover = false),
            recognizer: TapGestureRecognizer()..onTap = widget.onTap,
          ),
          TextSpan(
            text: widget.suffix,
            style: widget.normalStyle,
          ),
        ],
      ),
    );
  }
}
