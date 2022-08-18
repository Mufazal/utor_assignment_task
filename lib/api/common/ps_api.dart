import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:path/path.dart';
import 'package:utor_assignment/api/common/ps_api_reponse.dart';
import 'package:utor_assignment/api/common/ps_resource.dart';
import 'package:utor_assignment/api/common/ps_status.dart';

import '../../view_object/common/ps_object.dart';

abstract class PsApi {
  PsResource<T> psObjectConvert<T>(dynamic dataList, T data) {
    return PsResource<T>(dataList.status, dataList.message, data);
  }

  Future<List<dynamic>> getList(String url) async {
    final Client client = http.Client();
    try {
      final Response response = await client.get(Uri.parse(url));

      if (response.statusCode == 200 && response.body != '') {
        // parse into List
        final List<dynamic> parsed = json.decode(response.body);

        return parsed;
      } else {
        throw Exception('Error in loading...');
      }
    } finally {
      client.close();
    }
  }

  Future<PsResource<R>> getServerCall<T extends PsObject<dynamic>, R>(
      T obj, String url, Map<String, String>? header) async {
    final Client client = http.Client();
    try {
      final Response response = await client.get(Uri.parse(url));

      final PsApiResponse psApiResponse = PsApiResponse(response);

      log(response.body);
      if (psApiResponse.isSuccessful()) {
        final dynamic hashMap = json.decode(response.body);

        // log("All Dashboard apis ===================== " + hashMap);

        // if (!(hashMap is Map)) {
        //   final List<T> tList = <T>[];
        //   hashMap.forEach((dynamic data) {
        //     tList.add(obj.fromMap(data as dynamic));
        //   });
        //   return PsResource<R>(PsStatus.SUCCESS, '', tList);
        // } else {
        return PsResource<R>(PsStatus.SUCCESS, '', obj.fromJson(hashMap));
        // }
      } else {
        return PsResource<R>(PsStatus.ERROR, psApiResponse.errorMessage, null);
      }
    } catch (e) {
      print(e.toString());
      return PsResource<R>(PsStatus.ERROR, 'Server connection Error!', null);
    } finally {
      client.close();
    }
  }

  Future<PsResource<R>> postData<T extends PsObject<dynamic>, R>(
      T obj,
      String url,
      Map<dynamic, dynamic> jsonMap,
      Map<String, String>? header) async {
    final Client client = http.Client();

    try {
      final Response response = await client
          .post(Uri.parse(url),
              headers: header ??
                  <String, String>{
                    'content-type': 'application/json',
                  },
              body: json.encode(jsonMap))
          .catchError((dynamic e) {
        return PsResource<R>(PsStatus.ERROR, 'Server connection Error!', null);
      });

      final PsApiResponse psApiResponse = PsApiResponse(response);
      if (psApiResponse.isSuccessful()) {
        final dynamic hashMap = json.decode(psApiResponse.body!);

        // if (!(hashMap is Map)) {
        //   final List<T> tList = <T>[];
        //   hashMap.forEach((dynamic data) {
        //     tList.add(obj.fromMap(data));
        //   });
        //   return PsResource<R>(PsStatus.SUCCESS, '', tList ?? R);
        // } else {
        return PsResource<R>(PsStatus.SUCCESS, psApiResponse.errorMessage,
            obj.fromJson(hashMap));
        // }
      } else {
        return PsResource<R>(PsStatus.ERROR, psApiResponse.errorMessage, null);
      }
    } catch (e) {
      return PsResource<R>(
          PsStatus.ERROR, "Server connection Error", null); //e.message ??s
    } finally {
      client.close();
    }
  }

  Future<PsResource<R>> patchData<T extends PsObject<dynamic>, R>(
      T obj,
      String url,
      Map<dynamic, dynamic> jsonMap,
      Map<String, String>? header) async {
    final Client client = http.Client();

    print(jsonMap);
    try {
      final Response response = await client
          .patch(Uri.parse(url),
              headers: header ??
                  <String, String>{
                    'content-type': 'application/json',
                    // 'authorization':
                    //     'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhIjpbInRlc3RAdGVzdC5jb20iLCI2MjFjYWE3NTA3YzMwODAyMWM5ZjZiZGUiXSwicm9sZSI6InVzZXIiLCJpYXQiOjE2NDgxMDE4MDJ9.x1KfZsjqZZCNio6tPmTV21a6Vj6hFcmsybQdS64emTY'
                  },
              body: json.encode(jsonMap))
          .catchError((dynamic e) {
        print('** Error Post Data  ${e.message}');
        return PsResource<R>(PsStatus.ERROR, 'Connection Error!', null);
      });

      final PsApiResponse psApiResponse = PsApiResponse(response);

      print(psApiResponse.isSuccessful());

      print(psApiResponse.code);
      print(psApiResponse.body);
      if (psApiResponse.isSuccessful()) {
        final dynamic hashMap = json.decode(psApiResponse.body!);

        // if (!(hashMap is Map)) {
        //   final List<T> tList = <T>[];
        //   hashMap.forEach((dynamic data) {
        //     tList.add(obj.fromMap(data));
        //   });
        //   return PsResource<R>(PsStatus.SUCCESS, '', tList ?? R);
        // } else {
        return PsResource<R>(PsStatus.SUCCESS, psApiResponse.errorMessage,
            obj.fromJson(hashMap));
        // }
      } else {
        return PsResource<R>(PsStatus.ERROR, psApiResponse.errorMessage, null);
      }
    } catch (e) {
      print(" Error post data${e.toString()}");
      return PsResource<R>(PsStatus.ERROR, 'Server connection Error!', null);
    } finally {
      client.close();
    }
  }

  Future<PsResource<R>> postUploadImage<T extends PsObject<dynamic>, R>(T obj,
      String url, String userId, String platformName, File imageFile) async {
    final Client client = http.Client();
    try {
      final ByteStream stream =
          http.ByteStream(Stream.castFrom(imageFile.openRead()));
      final int length = await imageFile.length();

      final Uri uri = Uri.parse(url);

      final MultipartRequest request = http.MultipartRequest('POST', uri);
      final MultipartFile multipartFile = http.MultipartFile(
          'file', stream, length,
          filename: basename(imageFile.path));

      request.fields['user_id'] = userId;
      request.fields['platform_name'] = platformName;
      request.files.add(multipartFile);
      final StreamedResponse response = await request.send();

      final PsApiResponse psApiResponse =
          PsApiResponse(await http.Response.fromStream(response));

      if (psApiResponse.isSuccessful()) {
        final dynamic hashMap = json.decode(psApiResponse.body!);

        // if (!(hashMap is Map)) {
        //   final List<T> tList = <T>[];
        //   hashMap.forEach((dynamic data) {
        //     tList.add(obj.fromMap(data));
        //   });
        //   return PsResource<R>(PsStatus.SUCCESS, '', tList ?? R);
        // } else {
        return PsResource<R>(PsStatus.SUCCESS, '', obj.fromJson(hashMap));
        // }
      } else {
        return PsResource<R>(PsStatus.ERROR, psApiResponse.errorMessage, null);
      }
    } finally {
      client.close();
    }
  }
}
