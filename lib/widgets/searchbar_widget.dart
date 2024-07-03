import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/shared/network/remote/api_manager.dart';

import '../shared/styles/colors.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(12.0.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: searchController,
                style: const TextStyle(color: MyColors.textWhiteColor),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: MyColors.searchBarColor,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.r),
                    borderSide: const BorderSide(
                      color: MyColors.textWhiteColor,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.r),
                    borderSide: const BorderSide(
                      color: MyColors.textWhiteColor,
                    ),
                  ),
                  hintText: 'Search...',
                  hintStyle: const TextStyle(color: MyColors.textWhiteColor),
                  prefixIcon: IconButton(
                    icon: const Icon(Icons.search,
                        color: MyColors.textWhiteColor),
                    onPressed: () {
                      setState(() {});
                    },
                  ),
                  suffixIcon: IconButton(
                    icon:
                        const Icon(Icons.clear, color: MyColors.textWhiteColor),
                    onPressed: () {
                      searchController.clear();
                      setState(() {});
                    },
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Search must not be Empty";
                  }
                  return null;
                },
                onFieldSubmitted: (value) {
                  setState(() {});
                },
              ),
              SizedBox(height: 10.h),
              Expanded(
                child: FutureBuilder(
                  future: ApiManager.searchMovies(searchController.text),
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
                    var searchList = snapshot.data?.results ?? [];
                    if (searchList.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.local_movies,
                              size: 100.sp,
                              color: MyColors.primaryColor.withOpacity(.8),
                            ),
                            Text(
                              "No Movies Found",
                              style: TextStyle(
                                color: MyColors.primaryColor,
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return ListView.separated(
                      separatorBuilder: (context, index) => Container(
                        width: double.infinity,
                        height: 1,
                        color: MyColors.searchBarColor,
                      ),
                      itemCount: searchList.length,
                      itemBuilder: (context, index) {
                        var movie = searchList[index];
                        var backdropUrl = movie['backdrop_path'] != null
                            ? 'https://image.tmdb.org/t/p/w500${movie['backdrop_path']}'
                            : 'assets/images/category.png';
                        return ListTile(
                          title: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5.r),
                                child: movie['backdrop_path'] != null
                                    ? Image.network(
                                        backdropUrl,
                                        width: 150.w,
                                        height: 100.h,
                                        fit: BoxFit.fill,
                                      )
                                    : Image.asset(
                                        backdropUrl,
                                        width: 150.w,
                                        height: 100.h,
                                        fit: BoxFit.fill,
                                      ),
                              ),
                              SizedBox(width: 15.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      movie['title'],
                                      style: TextStyle(
                                        color: MyColors.primaryColor,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 8.h),
                                    Text(
                                      movie['overview'],
                                      style: TextStyle(
                                        color: MyColors.textWhiteColor,
                                        fontSize: 14.sp,
                                      ),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
