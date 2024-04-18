import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/layout/home.dart';
import 'package:movies_app/layout/movie_details.dart';
import 'package:movies_app/layout/splash.dart';
import 'package:movies_app/shared/styles/colors.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(412, 870),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            scaffoldBackgroundColor: MyColors.backgroundColor,
            appBarTheme: AppBarTheme(
              titleTextStyle: TextStyle(
                  color: MyColors.primaryColor,
                  fontSize: 26.sp,
                  fontWeight: FontWeight.bold),
              backgroundColor: MyColors.backgroundColor,
            ),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                backgroundColor: MyColors.navBarColor)),
        initialRoute: SplashScreen.routeName,
        routes: {
          SplashScreen.routeName: (context) => const SplashScreen(),
          HomePage.routeName: (context) => const HomePage(),
          MovieDetailsScreen.routeName: (context) => const MovieDetailsScreen(
              name: "",
              description: "",
              posterUrl: "",
              vote: "",
              releaseDate: "",
              imageUrl: "",
              backdropUrl: "")
        },
      ),
    );
  }
}
