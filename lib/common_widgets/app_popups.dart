import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:utor_assignment/common_widgets/spinner.dart';

class AppPopUps {
  bool isDialogShowing = true;

  showProgressDialog(
      {BuildContext? context, bool? barrierDismissal, Color? color}) {
    isDialogShowing = true;
    showDialog(
        useRootNavigator: false,
        useSafeArea: false,
        barrierDismissible: barrierDismissal ?? false,
        context: context!,
        builder: (context) => Center(
              child: Container(
                decoration: BoxDecoration(
                  //color: AppColors(..blackcardsBackground,
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(25.r)),
                  boxShadow: [
                    BoxShadow(
                      //  color: AppColors().shadowColor,
                      color: Colors.transparent,
                      spreadRadius: 5.r,
                      blurRadius: 5.r,
                      offset: const Offset(3, 5), // changes position of shadow
                    ),
                  ],
                ),
                height: 120.h,
                width: 120.h,
                //  child: Lottie.asset(AssetsNames().loader),
                child: spinner(color: color),
              ),
            )).then((value) {
      isDialogShowing = false;
    });
  }

  dissmissDialog(context) {
    if (isDialogShowing) {
      // navigatorKey.currentState!.pop();
      Navigator.pop(context);
    }
  }
}
