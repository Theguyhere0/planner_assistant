import 'package:flutter/material.dart';

import '../../../../theme/palette.dart';
import '../../../../utils/constants.dart';

class PageSection extends StatefulWidget {
  const PageSection(
    this.name, {
    Key? key,
    required this.icon,
    required this.content,
  }) : super(key: key);

  final IconData icon;
  final String name;
  final List<Widget> content;

  @override
  State<PageSection> createState() => _PageSection();
}

class _PageSection extends State<PageSection> {
  bool _sectionExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: defaultPadding),
      child: ExpansionTile(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: defaultPadding),
              child: Icon(
                widget.icon,
                color: _sectionExpanded
                    ? Palette.primaryText
                    : Palette.secondaryText,
                size: pageSectionIconSize,
              ),
            ),
            Text(
              widget.name,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: _sectionExpanded
                        ? Palette.primaryText
                        : Palette.secondaryText,
                  ),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: defaultPadding * 2),
                child: Divider(
                  thickness: 2,
                  color: _sectionExpanded
                      ? Palette.primaryText
                      : Palette.secondaryText,
                ),
              ),
            ),
          ],
        ),
        controlAffinity: ListTileControlAffinity.leading,
        leading: Icon(
          _sectionExpanded
              ? Icons.keyboard_arrow_down_rounded
              : Icons.chevron_right_rounded,
          color: _sectionExpanded ? Palette.primaryText : Palette.secondaryText,
          size: pageSectionIconSize,
        ),
        onExpansionChanged: (bool expanded) {
          setState(() => _sectionExpanded = expanded);
        },
        childrenPadding: const EdgeInsets.only(
          left: defaultPadding * 2,
          right: defaultPadding * 3,
        ),
        children: widget.content,
      ),
    );
  }
}
