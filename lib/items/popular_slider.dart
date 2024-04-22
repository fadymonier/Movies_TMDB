import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/models/watchlist_model.dart';
import 'package:movies_app/shared/network/remote/api_manager.dart';
import 'package:movies_app/shared/network/remote/firebase_functions.dart';

import '../layout/movie_details.dart';
import '../shared/components/constants.dart';
import '../shared/styles/colors.dart';

class PopularSlider extends StatefulWidget {
  const PopularSlider({super.key});

  @override
  State<PopularSlider> createState() => _PopularSliderState();
}

class _PopularSliderState extends State<PopularSlider> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: FutureBuilder(
        future: ApiManager.getPopularMovies(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: MyColors.primaryColor,
              ),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Something went Wrong !",
                style: TextStyle(
                  fontSize: 18.sp,
                  color: MyColors.primaryColor,
                ),
              ),
            );
          }
          var popularList = snapshot.data?.results ?? [];
          if (popularList.isEmpty) {
            return Center(
              child: Text(
                "No Results",
                style: TextStyle(
                  fontSize: 18.sp,
                  color: MyColors.primaryColor,
                ),
              ),
            );
          }
          return CarouselSlider.builder(
            itemCount: popularList.length,
            options: CarouselOptions(
              height: 300.h,
              viewportFraction: 1,
              initialPage: 0,
              enableInfiniteScroll: true,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 10),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              enlargeCenterPage: true,
              enlargeStrategy: CenterPageEnlargeStrategy.height,
              onPageChanged: (index, reason) {},
              scrollDirection: Axis.horizontal,
            ),
            itemBuilder: (context, index, realIndex) => Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  height: 290.h,
                  width: double.infinity,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CachedNetworkImage(
                        imageUrl:
                            '${Constants.imageURL}${snapshot.data?.results?[index].backdropPath}',
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(
                            color: MyColors.primaryColor,
                          ),
                        ),
                        fit: BoxFit.fill,
                        height: 220.h,
                        width: double.infinity,
                        filterQuality: FilterQuality.high,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0.r),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4.r),
                          child: Stack(
                            alignment: Alignment.topLeft,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            MovieDetailsScreen(
                                                name: popularList[index]
                                                        .title ??
                                                    "",
                                                description: popularList[
                                                            index]
                                                        .overview ??
                                                    "",
                                                posterUrl: popularList[
                                                            index]
                                                        .posterPath ??
                                                    "",
                                                vote: popularList[index]
                                                    .voteAverage
                                                    .toString(),
                                                releaseDate: popularList[index]
                                                        .releaseDate ??
                                                    "",
                                                imageUrl: Constants.imageURL,
                                                backdropUrl: popularList[index]
                                                        .backdropPath ??
                                                    ""),
                                      ));
                                },
                                child: CachedNetworkImage(
                                  imageUrl:
                                      '${Constants.imageURL}${snapshot.data?.results?[index].posterPath}',
                                  fit: BoxFit.contain,
                                  height: 200.h,
                                  width: 130.w,
                                  filterQuality: FilterQuality.high,
                                ),
                              ),
                              Stack(
                                alignment: Alignment.topCenter,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      WatchListModel model = WatchListModel(
                                          title: popularList[index].title ?? "",
                                          overview:
                                              popularList[index].overview ?? "",
                                          backDropPath:
                                              popularList[index].backdropPath ??
                                                  "");
                                      FirebaseFunctions.addToWatchList(model);
                                    },
                                    child: Icon(
                                      CupertinoIcons.bookmark_fill,
                                      color: Colors.white.withOpacity(0.75),
                                      size: 30.sp,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 25.r, left: 5.r),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: SizedBox(
                              width: 220.w,
                              child: Text(
                                "${snapshot.data?.results?[index].title}",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    overflow: TextOverflow.ellipsis,
                                    color: MyColors.primaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            "${snapshot.data?.results?[index].releaseDate}",
                            style:
                                TextStyle(fontSize: 10.sp, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
