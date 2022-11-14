import 'package:flutter/material.dart';

class TextCardTile extends StatelessWidget {
  const TextCardTile(
    this.title, {
    Key? key,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Container(
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        alignment: Alignment.center,
      ),
    );
  }
}
