import 'package:flutter/material.dart';

/// Player text widgets .
class PlayerText extends StatelessWidget {
  final String text;
  final int maxLines;
  final TextStyle style;

  const PlayerText(
      {Key? key,
      required this.text,
      required this.maxLines,
      required this.style})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 15),
      child: new Text(
        '${text}\n',
        style: style,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
      ),
    );
  }
}
