import 'package:planner_assistant/utils/constants.dart';
import 'package:flutter/material.dart';

import '../../utils/responsive.dart';

class InputDialog extends StatefulWidget {
  const InputDialog({
    Key? key,
    required this.onPress,
    required this.title,
    required this.labelText,
    required this.name,
  }) : super(key: key);

  final void Function() onPress;
  final String title;
  final String labelText;
  final String name;

  @override
  _InputDialogState createState() => _InputDialogState();
}

class _InputDialogState extends State<InputDialog> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.name,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final outlineInputBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.white,
        width: 1,
      ),
    );

    return Dialog(
      backgroundColor: secondaryColor,
      child: Container(
        padding: EdgeInsets.all(defaultPadding),
        width: Responsive.isMobile(context) ? screenSize.width * 0.7 : 285,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.title,
            ),
            SizedBox(
              height: defaultPadding,
            ),
            TextField(
              controller: _controller,
              autocorrect: true,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: defaultPadding / 2,
                  horizontal: defaultPadding / 2,
                ),
                labelStyle: TextStyle(color: Colors.grey.shade400),
                labelText: widget.labelText,
                focusedBorder: outlineInputBorder,
                enabledBorder: outlineInputBorder,
              ),
              cursorColor: Colors.grey.shade400,
            ),
            SizedBox(
              height: defaultPadding,
            ),
            ElevatedButton(
              style: TextButton.styleFrom(
                backgroundColor: primaryColor,
              ),
              onPressed: widget.onPress,
              child: Text('Done'),
            )
          ],
        ),
      ),
    );
  }
}
