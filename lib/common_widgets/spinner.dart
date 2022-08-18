import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../constants/pallete_constants.dart';

Center spinner({Color? color}) {
  return Center(
    child: SpinKitCircle(
      color: color ?? AppColor.kHeadingColor,
      size: 50.0,
    ),
  );
}
