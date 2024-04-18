import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/models/watchlist_model.dart';
import 'package:movies_app/shared/styles/colors.dart';
import 'package:movies_app/tabs/browse_tab.dart';
import 'package:movies_app/tabs/home_tab.dart';
import 'package:movies_app/tabs/search_tab.dart';
import 'package:movies_app/tabs/watchlist_tab.dart';

class HomePage extends StatefulWidget {
  static const String routeName = "HomePage";

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: MyColors.navBarColor,
        currentIndex: index,
        onTap: (value) {
          index = value;
          setState(() {});
        },
        unselectedFontSize: 10,
        selectedFontSize: 10,
        iconSize: 28,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.house_fill), label: "HOME"),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.search), label: "SEARCH"),
          BottomNavigationBarItem(icon: Icon(Icons.movie), label: "BROWSE"),
          BottomNavigationBarItem(
              icon: Icon(Icons.bookmarks_rounded), label: "WATCHLIST"),
        ],
      ),
      body: tabs[index],
    );
  }

  List<Widget> tabs = [
    const HomeTab(),
    const SearchTab(),
    const BrowseTab(),
    WatchListTab(
      model: WatchListModel(title: "", overview: "", backDropPath: ""),
    ),
  ];
}
