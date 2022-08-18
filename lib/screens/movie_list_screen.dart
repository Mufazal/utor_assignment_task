import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:utor_assignment/api/common/ps_status.dart';
import 'package:utor_assignment/constants/pallete_constants.dart';
import 'package:utor_assignment/controller/get_movies_list_controller.dart';
import 'package:utor_assignment/view_object/movie_model.dart';

class MovieListScreen extends StatefulWidget {
  const MovieListScreen({Key? key}) : super(key: key);

  @override
  State<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
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
              return Column(children: [
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
                    itemBuilder: (context, index) => topListViewItem(
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
                  height: 40.h,
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: TabBarView(children: [
                    Container(
                      color: Colors.red,
                      child: Icon(Icons.search),
                    ),
                    Container(
                      color: Colors.red,
                      child: Icon(Icons.search),
                    ),
                    Container(
                      color: Colors.red,
                      child: Icon(Icons.search),
                    ),
                    Container(
                      color: Colors.red,
                      child: Icon(Icons.search),
                    )
                  ]),
                )
              ]);
            }),
          ),
        ),
      ),
    );
  }

  topListViewItem({MovieResults? model, int? index}) {
    return ClipRect(
      child: Container(
        width: 130.w,
        //  height: 190.h,
        //  color: Colors.yellow,
        margin: EdgeInsets.only(right: 20.w),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 12.w, bottom: 10.h),
              child: Container(
                color: Colors.white,
                // decoration: BoxDecoration(
                //   image: DecorationImage(
                //     fit: BoxFit.fill,
                //     image: NetworkImage(
                //       "https://image.tmdb.org/t/p/w500${model!.posterPath}",
                //     ),
                //   ),
                // ),
                child: Image.network(
                  "https://image.tmdb.org/t/p/w500${model!.posterPath}",
                  frameBuilder:
                      (context, child, frame, wasSynchronouslyLoaded) => Center(
                    child: CircularProgressIndicator(
                        color: AppColor.kPrimaryColor),
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
                  index.toString(),
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      height: 1.44,
                      fontSize: 68.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
