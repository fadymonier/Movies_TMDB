import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/layout/movie_details.dart';
import 'package:movies_app/shared/network/remote/api_manager.dart';
import 'package:movies_app/shared/network/remote/firebase_functions.dart';

import '../models/watchlist_model.dart';
import '../shared/components/constants.dart';
import '../shared/styles/colors.dart';

class UpcomingSlider extends StatefulWidget {
  const UpcomingSlider({super.key});

  @override
  State<UpcomingSlider> createState() => _UpcomingSliderState();
}

class _UpcomingSliderState extends State<UpcomingSlider> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: FutureBuilder(
        future: ApiManager.getUpcomingMovies(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox();
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

          var upcomingList = snapshot.data?.results ?? [];
          if (upcomingList.isEmpty) {
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
          return Container(
            color: MyColors.secBackgroundColor,
            child: Padding(
              padding: EdgeInsets.only(left: 10.0.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "New Releases",
                    style: TextStyle(
                        color: MyColors.primaryColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  SizedBox(
                    height: 220.h,
                    width: 800.w,
                    child: ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(
                        width: 10.w,
                      ),
                      scrollDirection: Axis.horizontal,
                      itemCount: upcomingList.length,
                      itemBuilder: (context, index) {
                        return Stack(
                          alignment: Alignment.topLeft,
                          children: [
                            SizedBox(
                              height: 200.h,
                              width: 130.w,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(4.r),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              MovieDetailsScreen(
                                                  name: upcomingList[
                                                              index]
                                                          .title ??
                                                      "",
                                                  description: upcomingList[
                                                              index]
                                                          .overview ??
                                                      "",
                                                  posterUrl:
                                                      upcomingList[
                                                                  index]
                                                              .posterPath ??
                                                          "",
                                                  vote:
                                                      upcomingList[
                                                              index]
                                                          .voteAverage
                                                          .toString(),
                                                  releaseDate:
                                                      upcomingList[index]
                                                              .releaseDate ??
                                                          "",
                                                  imageUrl: Constants.imageURL,
                                                  backdropUrl:
                                                      upcomingList[index]
                                                              .backdropPath ??
                                                          ""),
                                        ));
                                  },
                                  child: CachedNetworkImage(
                                    fit: BoxFit.fill,
                                    imageUrl:
                                        '${Constants.imageURL}${snapshot.data!.results?[index].posterPath}',
                                    placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator(
                                        color: MyColors.primaryColor,
                                      ),
                                    ),
                                    filterQuality: FilterQuality.high,
                                    height: 130.h,
                                    width: double.infinity,
                                  ),
                                ),
                              ),
                            ),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    WatchListModel model = WatchListModel(
                                        title: upcomingList[index].title ?? "",
                                        overview:
                                            upcomingList[index].overview ?? "",
                                        backDropPath:
                                            upcomingList[index].backdropPath ??
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
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
