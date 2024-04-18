import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/items/searchbar_widget.dart';
import 'package:movies_app/shared/styles/colors.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        backgroundColor: Colors.transparent,
        title: Text(
          "Search",
          style: TextStyle(
              color: MyColors.primaryColor,
              fontSize: 26.sp,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: const SearchWidget(),
    );
  }
}
