import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

/// Icons for play controller .
class PlayControlIcons extends StatelessWidget {
  final IconData primaryIcon;
  final IconData secondaryIcon;
  final void Function()? function;
  final double size;
  final bool state;

  const PlayControlIcons(
      {Key? key,
      required this.primaryIcon,
      required this.secondaryIcon,
      required this.function,
      required this.size,
      required this.state})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20.w,
      child: Center(
        child: new IconButton(
            icon: (state)
                ? new Icon(
                    primaryIcon,
                    color: Theme.of(context).iconTheme.color,
                    size: size,
                  )
                : new Icon(
                    secondaryIcon,
                    color: Theme.of(context).iconTheme.color,
                    size: size,
                  ),
            onPressed: function),
      ),
    );
  }
}
