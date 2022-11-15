import 'package:flutter/material.dart';

import '../../theme/palette.dart';
import '../../utils/constants.dart';

/// A class for creating collapsible sections of a page.
class PageSection extends StatefulWidget {
  /// Creates a collapsible section of a page.
  const PageSection(
    this.name, {
    Key? key,
    required this.icon,
    required this.content,
  }) : super(key: key);

  /// An icon for the page section.
  final IconData icon;

  /// The name of the page section.
  final String name;

  /// The contents to display inside the page section.
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
            // The icon of the section
            Padding(
              padding: const EdgeInsets.only(right: defaultPadding),
              child: Icon(
                widget.icon,
                color: _sectionExpanded ? Palette.highlight : Palette.standard,
                size: pageSectionIconSize,
              ),
            ),
            // The name of the section
            Text(
              widget.name,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color:
                        _sectionExpanded ? Palette.highlight : Palette.standard,
                  ),
            ),
            // A divider taking up the rest of the section
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: defaultPadding * 2),
                child: Divider(
                  thickness: 2,
                  color:
                      _sectionExpanded ? Palette.highlight : Palette.standard,
                ),
              ),
            ),
          ],
        ),
        controlAffinity: ListTileControlAffinity.leading,
        // Toggle arrow
        leading: Icon(
          _sectionExpanded
              ? Icons.keyboard_arrow_down_rounded
              : Icons.chevron_right_rounded,
          color: _sectionExpanded ? Palette.highlight : Palette.standard,
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
