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
            return const Center(
              child: Text(
                "Something went Wrong !",
                style: TextStyle(
                  fontSize: 18,
                  color: MyColors.primaryColor,
                ),
              ),
            );
          }
          var popularList = snapshot.data?.results ?? [];
          if (popularList.isEmpty) {
            return const Center(
              child: Text(
                "No Results",
                style: TextStyle(
                  fontSize: 18,
                  color: MyColors.primaryColor,
                ),
              ),
            );
          }
          return CarouselSlider.builder(
            itemCount: popularList.length,
            options: CarouselOptions(
              height: 300,
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
                  height: 290,
                  width: double.infinity,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.network(
                        '${Constants.imageURL}${snapshot.data?.results?[index].backdropPath}',
                        fit: BoxFit.fill,
                        height: 220,
                        width: double.infinity,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
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
                                child: Image.network(
                                  '${Constants.imageURL}${snapshot.data?.results?[index].posterPath}',
                                  fit: BoxFit.fill,
                                  height: 200,
                                  width: 130,
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
                                      size: 30,
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
                      padding: const EdgeInsets.only(bottom: 25, left: 5),
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
                                    fontSize: 13.sp,
                                    overflow: TextOverflow.fade,
                                    color: MyColors.primaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
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
