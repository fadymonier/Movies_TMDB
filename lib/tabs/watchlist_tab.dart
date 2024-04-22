import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/models/watchlist_model.dart';
import 'package:movies_app/shared/components/constants.dart';
import 'package:movies_app/shared/network/remote/firebase_functions.dart';

import '../shared/styles/colors.dart';

class WatchListTab extends StatefulWidget {
  final WatchListModel model;

  const WatchListTab({super.key, required this.model});

  @override
  State<WatchListTab> createState() => _WatchListTabState();
}

class _WatchListTabState extends State<WatchListTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      appBar: AppBar(
        leading: const SizedBox(),
        backgroundColor: Colors.transparent,
        title: Text(
          "WatchList",
          style: TextStyle(
            color: MyColors.primaryColor,
            fontSize: 26.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder(
        future: FirebaseFunctions.getMovie(),
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
                "Something Went Wrong!",
                style: TextStyle(fontSize: 18.sp, color: MyColors.primaryColor),
              ),
            );
          }
          List<WatchListModel> watchList =
              snapshot.data?.docs.map((doc) => doc.data()).toList() ?? [];
          if (watchList.isEmpty) {
            return Center(
              child: Text(
                "WatchList is Empty !",
                style: TextStyle(
                    fontSize: 18.sp,
                    color: MyColors.primaryColor,
                    fontWeight: FontWeight.w600),
              ),
            );
          }
          return ListView.separated(
            separatorBuilder: (context, index) => Container(
              width: double.infinity,
              height: 1,
              color: MyColors.searchBarColor,
            ),
            scrollDirection: Axis.vertical,
            itemCount: watchList.length,
            itemBuilder: (context, index) {
              WatchListModel currentItem = watchList[index];
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: SizedBox(
                  width: 600.w,
                  child: Row(
                    children: [
                      Stack(
                        alignment: Alignment.topLeft,
                        children: [
                          SizedBox(
                            height: 90,
                            width: 160,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: CachedNetworkImage(
                                imageUrl:
                                    "${Constants.imageURL}${currentItem.backDropPath}",
                                fit: BoxFit.fill,
                                placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(
                                    color: MyColors.primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  FirebaseFunctions.removeFromWatchList(
                                      currentItem.id);
                                  setState(() {});
                                },
                                child: Icon(
                                  CupertinoIcons.bookmark_fill,
                                  color:
                                      MyColors.primaryColor.withOpacity(0.75),
                                  size: 30,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              currentItem.title,
                              style: TextStyle(
                                color: MyColors.primaryColor,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              currentItem.overview,
                              style: TextStyle(
                                color: MyColors.textWhiteColor,
                                fontSize: 12.sp,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
