import 'package:flutter/material.dart';

/// SettingsOption widgets .
class SettingsOptions extends StatelessWidget {
  SettingsOptions(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.function,
      required this.icon})
      : super(key: key);

  final String title;
  final String subtitle;
  final void Function()? function;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.all(8.0),
      width: double.infinity,
      height: 70.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          size: 40,
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        onTap: function,
      ),
    );
  }
}
