import 'dart:convert';

import 'package:utor_assignment/view_object/common/ps_object.dart';

class ApiResponse extends PsObject<ApiResponse> {
  bool? success;
  String? message;
  dynamic data;
  ApiResponse({
    this.success,
    this.message,
    this.data,
  });

  ApiResponse copyWith({
    bool? success,
    String? message,
    dynamic data,
  }) {
    return ApiResponse(
      success: success ?? this.success,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  factory ApiResponse.fromMap(Map<dynamic, dynamic> map) {
    return ApiResponse(
      success: map['success'],
      message: map['message'],
      data: map['data'],
    );
  }

  factory ApiResponse.fromJson(String source) =>
      ApiResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'ApiResponse(success: $success, message: $message, data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ApiResponse &&
        other.success == success &&
        other.message == message &&
        other.data == data;
  }

  @override
  int get hashCode => success.hashCode ^ message.hashCode ^ data.hashCode;

  @override
  ApiResponse fromJson(dynamicData) {
    return ApiResponse.fromMap(dynamicData);
  }

  @override
  List<ApiResponse> fromMapList(List dynamicDataList) {
    // TODO: implement fromMapList
    throw UnimplementedError();
  }

  @override
  String getPrimaryKey() {
    // TODO: implement getPrimaryKey
    throw UnimplementedError();
  }

  @override
  List<Map<String, dynamic>> toMapList(List<ApiResponse> objectList) {
    // TODO: implement toMapList
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic> toJson(ApiResponse object) {
    return {
      'success': success,
      'message': message,
      'data': data,
    };
  }
}
