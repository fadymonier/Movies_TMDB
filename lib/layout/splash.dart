import 'dart:async';
import 'package:flutter/material.dart';
import 'package:movies_app/layout/home.dart';
import 'package:movies_app/shared/styles/colors.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "SplashScreen";

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacementNamed(HomePage.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      body: SizedBox(
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: [
            const Image(
              filterQuality: FilterQuality.high,

              image: AssetImage(

                "assets/images/movies.png",
              ),
              width: 168,
              height: 187,
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: const Image(
                filterQuality: FilterQuality.high,
                image: AssetImage(
                  "assets/images/RouteLogo.png",
                ),
                width: 128,
                height: 128,
              ),
            ),

          ],
        ),
      ),
    );
  }
}
