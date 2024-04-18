import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/shared/network/remote/api_manager.dart';
import 'package:movies_app/shared/styles/colors.dart';

class BrowseTab extends StatelessWidget {
  const BrowseTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        backgroundColor: Colors.transparent,
        title: Text(
          "Browse Category",
          style: TextStyle(
              color: MyColors.primaryColor,
              fontSize: 26.sp,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder(
        future: ApiManager.getCategories(),
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

          var categoriesList = snapshot.data?.genres ?? [];
          if (categoriesList.isEmpty) {
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

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: categoriesList.length,
            itemBuilder: (context, index) {
              final category = categoriesList[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Image.asset(
                        MyCategoriesList
                                .categories[category.name!.toLowerCase()] ??
                            '',
                        width: 200.w,
                        height: 100.h,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Text(
                      category.name!,
                      style: TextStyle(
                        color: MyColors.textWhiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class MyCategoriesList {
  static final Map<String, String> categories = {
    'action': 'assets/images/action.png',
    'adventure': 'assets/images/adventure.png',
    'animation': 'assets/images/animation.png',
    'comedy': 'assets/images/comedy.png',
    'crime': 'assets/images/crime.png',
    'documentary': 'assets/images/documentary.png',
    'drama': 'assets/images/drama.png',
    'family': 'assets/images/family.png',
    'fantasy': 'assets/images/fantasy.png',
    'horror': 'assets/images/horror.png',
    'music': 'assets/images/music.png',
    'history': 'assets/images/history.png',
    'mystery': 'assets/images/mystery.png',
    'romance': 'assets/images/romance.png',
    'Science fiction': 'assets/images/sciencefiction.png',
    'tv movie': 'assets/images/tvmovie.png',
    'thriller': 'assets/images/thriller.png',
    'war': 'assets/images/war.png',
    'western': 'assets/images/western.png',
  };
}
