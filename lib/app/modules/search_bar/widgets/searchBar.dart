import 'package:flutter/material.dart';
import 'package:hougaku/app/modules/search_bar/search_controller.dart';
import 'package:sizer/sizer.dart';

/// SearchBar widget .
class SearchBar extends StatelessWidget {
  final String hintText;
  final SearchController controller;

  const SearchBar({Key? key, required this.hintText, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 16.w,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          decoration: InputDecoration(
              suffixIcon: Icon(
                Icons.search,
                color: Colors.black,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              filled: true,
              hintStyle: TextStyle(color: Colors.grey[700]),
              hintText: hintText,
              fillColor: Theme.of(context).hoverColor),
          onChanged: (value) {
            controller.search(value);
          },
        ),
      ),
    );
  }
}
