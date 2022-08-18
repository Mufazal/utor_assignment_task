abstract class PsObject<T> {
  String key = '0';

  String getPrimaryKey();

  T fromJson(dynamic dynamicData);

  Map<String, dynamic> toJson(T object);

  List<T> fromMapList(List<dynamic> dynamicDataList);

  List<Map<String, dynamic>> toMapList(List<T> objectList);
}
