import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/shared/styles/colors.dart';

class MovieDetailsScreen extends StatelessWidget {
  static const String routeName = "MovieDetailsScreen";
  final String name,
      description,
      posterUrl,
      vote,
      releaseDate,
      backdropUrl,
      imageUrl;

  const MovieDetailsScreen(
      {super.key,
      required this.name,
      required this.description,
      required this.posterUrl,
      required this.vote,
      required this.releaseDate,
      required this.imageUrl,
      required this.backdropUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.navBarColor,
        centerTitle: true,
        title: Text(
          name,
          style: TextStyle(color: MyColors.primaryColor, fontSize: 18.sp),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: MyColors.primaryColor,
            size: 30,
          ),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            width: double.infinity,
            child: CachedNetworkImage(
              imageUrl: imageUrl + backdropUrl,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(
                  color: MyColors.primaryColor,
                ),
              ),
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              name,
              style: TextStyle(
                  color: MyColors.primaryColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              releaseDate,
              style: TextStyle(color: Colors.grey, fontSize: 12.sp),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: SizedBox(
                  height: 200,
                  child: CachedNetworkImage(
                    imageUrl: imageUrl + posterUrl,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(
                        color: MyColors.primaryColor,
                      ),
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: SizedBox(
                      width: 250,
                      child: Text(
                        maxLines: 8,
                        overflow: TextOverflow.ellipsis,
                        description,
                        style: const TextStyle(
                            color: MyColors.textDetailsColor, fontSize: 14),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          color: MyColors.primaryColor,
                          size: 30,
                        ),
                        Text(
                          double.parse(vote).toStringAsFixed(1),
                          style: const TextStyle(
                              color: MyColors.textWhiteColor, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
