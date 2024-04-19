import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/layout/movie_details.dart';
import 'package:movies_app/models/watchlist_model.dart';
import 'package:movies_app/shared/network/remote/api_manager.dart';
import 'package:movies_app/shared/network/remote/firebase_functions.dart';

import '../shared/components/constants.dart';
import '../shared/styles/colors.dart';

class TopRatedSlider extends StatefulWidget {
  const TopRatedSlider({super.key});

  @override
  State<TopRatedSlider> createState() => _TopRatedSliderState();
}

class _TopRatedSliderState extends State<TopRatedSlider> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: FutureBuilder(
        future: ApiManager.getTopRatedMovies(),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
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
          var topRatedList = snapshot.data?.results ?? [];
          if (topRatedList.isEmpty) {
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
                    "Top Rated",
                    style: TextStyle(
                        color: MyColors.primaryColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  SizedBox(
                    height: 280.h,
                    width: 700.w,
                    child: ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(
                        width: 10.w,
                      ),
                      scrollDirection: Axis.horizontal,
                      itemCount: topRatedList.length,
                      itemBuilder: (context, index) {
                        final movie = topRatedList[index];
                        final voteAverage = movie.voteAverage;
                        return Stack(
                          alignment: Alignment.topLeft,
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  height: 200.h,
                                  width: 130.w,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(5.r),
                                        topRight: Radius.circular(5.r)),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  MovieDetailsScreen(
                                                      name: topRatedList[index]
                                                              .title ??
                                                          "",
                                                      description: topRatedList[
                                                                  index]
                                                              .overview ??
                                                          "",
                                                      posterUrl: topRatedList[index]
                                                              .posterPath ??
                                                          "",
                                                      vote:
                                                          topRatedList[index]
                                                              .voteAverage
                                                              .toString(),
                                                      releaseDate:
                                                          topRatedList[index]
                                                                  .releaseDate ??
                                                              "",
                                                      imageUrl:
                                                          Constants.imageURL,
                                                      backdropUrl: topRatedList[
                                                                  index]
                                                              .backdropPath ??
                                                          ""),
                                            ));
                                      },
                                      child: Image.network(
                                        '${Constants.imageURL}${movie.posterPath}',
                                        filterQuality: FilterQuality.high,
                                        height: 50.h,
                                        width: double.infinity,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: MyColors.ratingColor,
                                      boxShadow: [
                                        BoxShadow(
                                            color: MyColors.navBarColor,
                                            spreadRadius: 3.r,
                                            blurRadius: 5)
                                      ],
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(4.r),
                                          bottomLeft: Radius.circular(4.r))),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        width: 100.w,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.star_rounded,
                                              color: MyColors.primaryColor,
                                              size: 20.sp,
                                            ),
                                            SizedBox(
                                              width: 3.w,
                                            ),
                                            Text(
                                              voteAverage.toStringAsFixed(1),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: TextStyle(
                                                  overflow: TextOverflow.fade,
                                                  color:
                                                      MyColors.textWhiteColor,
                                                  fontSize: 14.sp),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 120.w,
                                        child: Text(
                                          movie.title,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: const TextStyle(
                                            overflow: TextOverflow.fade,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 130.w,
                                        child: Text(
                                          movie.releaseDate,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                              overflow: TextOverflow.fade,
                                              color: Colors.grey,
                                              fontSize: 12.sp),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              top: 5,
                              right: 5,
                              child: InkWell(
                                onTap: () {
                                  WatchListModel model = WatchListModel(
                                      title: topRatedList[index].title ?? "",
                                      overview:
                                          topRatedList[index].overview ?? "",
                                      backDropPath:
                                          topRatedList[index].backdropPath ??
                                              "");
                                  FirebaseFunctions.addToWatchList(model);
                                },
                                child: Icon(
                                  CupertinoIcons.bookmark_fill,
                                  color:
                                      MyColors.textWhiteColor.withOpacity(0.75),
                                  size: 30.sp,
                                ),
                              ),
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
