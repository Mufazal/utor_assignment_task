import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:utor_assignment/constants/pallete_constants.dart';
import 'package:utor_assignment/routes.dart';
import 'package:utor_assignment/screens/movie_list_screen.dart';

void main() {
  runApp(const ParentWidget());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height),
      builder: (context, child) => MaterialApp(
        theme: ThemeData(
          iconTheme: const IconThemeData(color: AppColor.kPrimaryColor),
        ),
        debugShowCheckedModeBanner: false,
        debugShowMaterialGrid: false,
        routes: routes,
        home: MovieListScreen(),
      ),
    );
  }
}

class ParentWidget extends StatelessWidget {
  const ParentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: multiProviders,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const MyApp(),
        navigatorKey: navigatorKey,
      ),
    );
  }
}
