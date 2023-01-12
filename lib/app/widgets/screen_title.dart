import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ScreenTitle extends StatelessWidget {
  final String title;

  const ScreenTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 5.w),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline4,
      ),
    );
  }
}
