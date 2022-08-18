import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:utor_assignment/controller/get_movies_list_controller.dart';
import 'package:utor_assignment/screens/movie_detail_screen.dart';
import 'package:utor_assignment/screens/movie_list_screen.dart';

import 'constants/screen_constants.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
BuildContext? myContext = navigatorKey.currentState!.context;

final Map<String, Widget Function(BuildContext)> routes = {
  Screens.movieListScreen: (ctx) => MovieListScreen(),
  Screens.movieDetalScreen: (ctx) => MovieDetailScreen(),
};

final List<ChangeNotifierProvider<dynamic>> multiProviders = [
  ChangeNotifierProvider<GetMoviesListController>(
      create: (context) => GetMoviesListController()),
];
