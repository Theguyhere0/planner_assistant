import 'package:flutter/material.dart';

import '../../../theme/palette.dart';
import '../../../utils/constants.dart';

const List<String> list = <String>[
  'One',
  'Two',
  'Three',
  'Four',
  'Five',
  'Six',
  'Seven',
  'Eight'
];

class DropdownCardTile extends StatefulWidget {
  const DropdownCardTile(
    this.title, {
    Key? key,
    this.label = true,
  }) : super(key: key);

  final String title;
  final bool label;

  @override
  State<DropdownCardTile> createState() => _DropdownCardTileState();
}

class _DropdownCardTileState extends State<DropdownCardTile> {
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return widget.label
        ? ListTile(
            leading: Container(
              child: Text(
                widget.title,
                textAlign: TextAlign.right,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              width: cardTileTitleWidth,
              alignment: Alignment.centerRight,
            ),
            title: Container(
              alignment: Alignment.centerLeft,
              child: Theme(
                data: Theme.of(context).copyWith(
                  focusColor: Colors.transparent,
                  hoverColor: Palette.focus,
                ),
                child: DropdownButton(
                  value: dropdownValue,
                  hint: const Text('Choose an option'),
                  iconEnabledColor: Palette.standard,
                  focusColor: Colors.transparent,
                  borderRadius: BorderRadius.circular(defaultPadding),
                  underline: Container(),
                  menuMaxHeight: 250,
                  items: list.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: defaultPadding),
                        child: Text(value),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      dropdownValue = value!;
                    });
                  },
                ),
              ),
            ),
          )
        : ListTile(
            title: Container(
              child: Theme(
                data: Theme.of(context).copyWith(
                  focusColor: Colors.transparent,
                  hoverColor: Palette.focus,
                ),
                child: DropdownButton(
                  value: dropdownValue,
                  hint: Text(widget.title),
                  iconEnabledColor: Palette.standard,
                  focusColor: Colors.transparent,
                  borderRadius: BorderRadius.circular(defaultPadding),
                  underline: Container(),
                  menuMaxHeight: 250,
                  items: list.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: defaultPadding),
                        child: Text(value),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      dropdownValue = value!;
                    });
                  },
                ),
              ),
              alignment: Alignment.center,
            ),
          );
  }
}
