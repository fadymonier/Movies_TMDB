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

          var upcomingList = snapshot.data?.results ?? [];
          if (upcomingList.isEmpty) {
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
          return Container(
            color: MyColors.secBackgroundColor,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "New Releases",
                    style: TextStyle(
                        color: MyColors.primaryColor,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 200,
                    width: 800,
                    child: ListView.separated(
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 10,
                      ),
                      scrollDirection: Axis.horizontal,
                      itemCount: upcomingList.length,
                      itemBuilder: (context, index) {
                        return Stack(
                          alignment: Alignment.topLeft,
                          children: [
                            SizedBox(
                              height: 190,
                              width: 130,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(4),
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
                                  child: Image.network(
                                    fit: BoxFit.fill,
                                    '${Constants.imageURL}${snapshot.data!.results?[index].posterPath}',
                                    filterQuality: FilterQuality.high,
                                    height: 50,
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
                                    size: 30,
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
