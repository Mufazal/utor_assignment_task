// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:utor_assignment/constants/pallete_constants.dart';

import 'package:utor_assignment/view_object/movie_model.dart';

class MovieDetailScreen extends StatelessWidget {
  final MovieResults? model;
  MovieDetailScreen({
    Key? key,
    this.model,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColor.kPrimaryColor,
        appBar: AppBar(
          titleSpacing: 0,
          elevation: 0,
          title: Text("Detail"),
          actions: [],
          centerTitle: true,
          backgroundColor: AppColor.kPrimaryColor,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 300.h,
                child: Stack(children: [
                  Container(
                    height: 220,
                    width: MediaQuery.of(context).size.width,
                    child: Image.network(
                      "https://image.tmdb.org/t/p/w500${model!.backdropPath}",
                      fit: BoxFit.fill,

                      errorBuilder: (context, child, loadingProgress) =>
                          Center(child: Icon(Icons.error)),
                      // frameBuilder:
                      //     (context, child, frame, wasSynchronouslyLoaded) =>
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    child: SizedBox(
                      height: 150.h,
                      child: Row(children: [
                        SizedBox(
                          width: 20.w,
                        ),
                        Container(
                          height: 150.h,
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            child: Container(
                              child: Image.network(
                                "https://image.tmdb.org/t/p/w500${model!.posterPath}",

                                errorBuilder:
                                    (context, child, loadingProgress) =>
                                        Center(child: Icon(Icons.error)),
                                // frameBuilder:
                                //     (context, child, frame, wasSynchronouslyLoaded) =>
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 10.w, bottom: 22.h, right: 15.w),
                              child: Text(
                                "${model?.title}",
                                maxLines: 2,
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    color: AppColor.kLabelColor),
                              ),
                            ),
                          ),
                        )
                      ]),
                    ),
                  )
                ]),
              ),
              SizedBox(
                height: 30.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w),
                child:
                    TabBar(indicatorColor: AppColor.kDescriptionColor, tabs: [
                  Tab(
                    child: Text(
                      "About Movie",
                      maxLines: 1,
                      style: TextStyle(fontSize: 10.sp),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Reviews",
                      maxLines: 1,
                      style: TextStyle(fontSize: 10.sp),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Cast",
                      maxLines: 1,
                      style: TextStyle(fontSize: 10.sp),
                    ),
                  ),
                ]),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30.h, left: 20.w, right: 20.w),
                child: Container(
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.blue,
                          child: Icon(Icons.person),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Flexible(
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "ZeBlah",
                                  style: TextStyle(
                                      color: AppColor.kDescriptionColor),
                                ),
                                Text(
                                  "${model?.overview}",
                                  overflow: TextOverflow.clip,
                                  maxLines: 10,
                                  style: TextStyle(
                                      color: AppColor.kDescriptionColor),
                                ),
                              ],
                            ),
                          ),
                        )
                      ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
