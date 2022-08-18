import 'package:flutter/cupertino.dart';
import 'package:utor_assignment/api/common/ps_resource.dart';
import 'package:utor_assignment/api/common/ps_status.dart';
import 'package:utor_assignment/api/ps_api_service.dart';
import 'package:utor_assignment/utils/utils.dart';
import 'package:utor_assignment/view_object/movie_model.dart';

import '../common_widgets/flushbar_widget.dart';

class GetMoviesListController with ChangeNotifier {
  PsResource<MovieModel>? resource;
  MovieModel? model;

  getMoviesList(context) async {
    resource = PsResource(PsStatus.BLOCK_LOADING, "", null);
    if (await Utils.checkInternetConnectivity()) {
      resource = await PsApiService.instance.getMoviesListData();
      if (resource?.data != null) {
        resource = await PsApiService.instance.getMoviesListData();
        if (resource!.status == PsStatus.SUCCESS) {
          model = resource?.data;
        } else if (resource!.status == PsStatus.ERROR) {
          resource = resource = PsResource(PsStatus.ERROR, "", null);
          showFlushBar(context!, "connectivity error");
        }
      } else {
        resource = resource = PsResource(PsStatus.ERROR, "", null);
        showFlushBar(context!, "connectivity error");
      }
    } else {
      resource = PsResource(PsStatus.ERROR, "", null);
      showFlushBar(context!, "connectivity error");
    }
    notifyListeners();
  }
}
