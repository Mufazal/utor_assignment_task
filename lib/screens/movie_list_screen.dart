import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:utor_assignment/api/common/ps_status.dart';
import 'package:utor_assignment/constants/pallete_constants.dart';
import 'package:utor_assignment/controller/get_movies_list_controller.dart';
import 'package:utor_assignment/screens/movie_detail_screen.dart';
import 'package:utor_assignment/view_object/movie_model.dart';

class MovieListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var viewController =
        Provider.of<GetMoviesListController>(context, listen: false);

    viewController.getMoviesList(context);
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: AppColor.kPrimaryColor,
        appBar: AppBar(
          title: Text("What do you want to watch?"),
          elevation: 0,
          backgroundColor: AppColor.kPrimaryColor,
        ),
        body: SizedBox(
          child: SingleChildScrollView(
            child: Consumer<GetMoviesListController>(
                builder: (context, value, child) {
              log("${value.model?.results.toString()}");
              log("${value.resource?.status.toString()}");
              if (value.resource?.status == PsStatus.BLOCK_LOADING) {
                return Container(
                  height: MediaQuery.of(context).size.height,
                  alignment: Alignment.center,
                  child: const Center(
                      child: CircularProgressIndicator(
                    color: AppColor.kDescriptionColor,
                  )),
                );
              } else if (value.resource?.status == PsStatus.ERROR) {
                return Container(
                  height: MediaQuery.of(context).size.height,
                  alignment: Alignment.center,
                  child: const Center(child: Text("Connectivity error")),
                );
              }
              return Padding(
                padding: EdgeInsets.only(left: 18.w, right: 18.w),
                child: Column(children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    height: 45.h,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(13))),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Search",
                              style: TextStyle(
                                color: AppColor.kDescriptionColor,
                              ),
                            ),
                            Icon(
                              Icons.search,
                              color: AppColor.kDescriptionColor,
                            )
                          ]),
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Container(
                    height: 200.h,
                    // color: Colors.white,
                    child: ListView.builder(
                      itemCount: 6,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => topListViewItem(context,
                          model: value.model?.results?[index], index: index),
                    ),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  TabBar(indicatorColor: AppColor.kDescriptionColor, tabs: [
                    Tab(
                      child: Text(
                        "Now playing",
                        maxLines: 1,
                        style: TextStyle(fontSize: 10.sp),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Upcoming",
                        maxLines: 1,
                        style: TextStyle(fontSize: 10.sp),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Top Reted",
                        maxLines: 1,
                        style: TextStyle(fontSize: 10.sp),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Popular",
                        maxLines: 1,
                        style: TextStyle(fontSize: 10.sp),
                      ),
                    )
                  ]),
                  SizedBox(
                    height: 15.h,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: TabBarView(children: [
                      Container(
                          width: MediaQuery.of(context).size.width,
                          child: GridView.count(
                              crossAxisCount: 3,
                              //  crossAxisSpacing: 10,
                              shrinkWrap: false,
                              mainAxisSpacing: 10,
                              children: List.generate(
                                value.model?.results?.length ?? 0,
                                (index) {
                                  return Center(
                                    child: gridViewItem(
                                        context: context,
                                        model: value.model?.results?[index],
                                        index: index),
                                  );
                                },
                              ))),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          child: GridView.count(
                              crossAxisCount: 3,
                              //  crossAxisSpacing: 10,
                              shrinkWrap: false,
                              mainAxisSpacing: 10,
                              children: List.generate(
                                value.model?.results?.length ?? 0,
                                (index) {
                                  return Center(
                                    child: gridViewItem(
                                        context: context,
                                        model: value.model?.results?[index],
                                        index: index),
                                  );
                                },
                              ))),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          child: GridView.count(
                              crossAxisCount: 3,
                              //  crossAxisSpacing: 10,
                              shrinkWrap: false,
                              mainAxisSpacing: 10,
                              children: List.generate(
                                value.model?.results?.length ?? 0,
                                (index) {
                                  return Center(
                                    child: gridViewItem(
                                        context: context,
                                        model: value.model?.results?[index],
                                        index: index),
                                  );
                                },
                              ))),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          child: GridView.count(
                              crossAxisCount: 3,
                              padding: EdgeInsets.all(0),
                              mainAxisSpacing: 10,
                              children: List.generate(
                                value.model?.results?.length ?? 0,
                                (index) {
                                  return Center(
                                    child: gridViewItem(
                                        context: context,
                                        model: value.model?.results?[index],
                                        index: index),
                                  );
                                },
                              ))),
                    ]),
                  )
                ]),
              );
            }),
          ),
        ),
      ),
    );
  }

  topListViewItem(context, {MovieResults? model, int? index}) {
    print(model?.posterPath);
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MovieDetailScreen(
                      model: model,
                    )));
      },
      child: ClipRect(
        child: Container(
          width: 150.w,
          //  height: 190.h,
          //  color: Colors.yellow,
          margin: EdgeInsets.only(right: 20.w),
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 14.w, bottom: 5.h),
                child: Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: Image.network(
                      "https://image.tmdb.org/t/p/w500${model!.posterPath}",

                      errorBuilder: (context, child, loadingProgress) =>
                          Center(child: Icon(Icons.error)),
                      // frameBuilder:
                      //     (context, child, frame, wasSynchronouslyLoaded) =>
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.bottomLeft,
                child: Container(
                  height: 80.h,
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    (index! + 1).toString(),
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        height: 1.47,
                        fontSize: 68.sp,
                        color: AppColor.kDescriptionColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  gridViewItem({context, MovieResults? model, int? index}) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MovieDetailScreen(
                      model: model,
                    )));
      },
      child: Container(
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          child: Container(
            child: Image.network(
              "https://image.tmdb.org/t/p/w500${model!.posterPath}",

              errorBuilder: (context, child, loadingProgress) =>
                  Center(child: Icon(Icons.error)),
              // frameBuilder:
              //     (context, child, frame, wasSynchronouslyLoaded) =>
            ),
          ),
        ),
      ),
    );
  }
}
