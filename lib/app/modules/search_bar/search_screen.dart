import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hougaku/app/modules/search_bar/search_controller.dart';
import 'package:hougaku/app/modules/search_bar/widgets/verticalSongList.dart';
import 'package:hougaku/app/modules/search_bar/widgets/searchBar.dart';
import 'package:sizer/sizer.dart';

class SearchScreen extends GetView<SearchController> {
  SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      //shadowColor:  Theme.of(context).scaffoldBackgroundColor,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      foregroundColor: Theme.of(context).primaryColorDark,
      elevation: 0,
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SearchBar(hintText: "Search your songs", controller: controller),
          GetBuilder<SearchController>(
              builder: (_) => VerticalSongList(
                songs: controller.convertedSongs,
                appBar: appBar,
              ))
        ]),
      ),
    );
  }
}
