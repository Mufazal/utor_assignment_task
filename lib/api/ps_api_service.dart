import 'package:utor_assignment/api/api_url.dart';
import 'package:utor_assignment/api/common/ps_resource.dart';
import 'package:utor_assignment/view_object/movie_model.dart';

import 'common/ps_api.dart';

class PsApiService extends PsApi {
  static final PsApiService instance = PsApiService._internal();

  PsApiService._internal();
  factory PsApiService() {
    return instance;
  }

  //
  // Get Movies List
  //
  Future<PsResource<MovieModel>> getMoviesListData(
      {Map<String, String>? header}) async {
    String url = ApiUrl.moviesUrl;
    return await getServerCall<MovieModel, MovieModel>(
        MovieModel(), url, header);
  }
}
