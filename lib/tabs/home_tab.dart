// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/items/popular_slider.dart';
import 'package:movies_app/items/topRated_slider.dart';
import 'package:movies_app/items/upcoming_slider.dart';
import 'package:movies_app/shared/styles/colors.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: MyColors.backgroundColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: 1000,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SafeArea(
                child: PopularSlider(),
              ),
              SizedBox(
                height: 20,
              ),
              UpcomingSlider(),
              SizedBox(
                height: 20,
              ),
              TopRatedSlider(),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
