// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/widgets/popular_slider.dart';
import 'package:movies_app/widgets/toprated_slider.dart';
import 'package:movies_app/widgets/upcoming_slider.dart';
import 'package:movies_app/shared/styles/colors.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: 990.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SafeArea(
                child: PopularSlider(),
              ),
              SizedBox(
                height: 15.h,
              ),
              const UpcomingSlider(),
              SizedBox(
                height: 20.h,
              ),
              const TopRatedSlider(),
              SizedBox(
                height: 30.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
