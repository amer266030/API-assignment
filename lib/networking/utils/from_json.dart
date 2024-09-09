import 'dart:convert';

class FromJson {
  static Future<List<T>> decodeItems<T>({
    required String responseBody,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    if (responseBody.isEmpty) {
      throw Exception('Response body is empty');
    } else {
      var jsonResult = json.decode(responseBody);

      if (jsonResult is! List) {
        throw Exception(
            'Expected a list in the response but got ${jsonResult.runtimeType}');
      }

      try {
        List<T> objects = List<T>.from(jsonResult.map((jsonItem) {
          if (jsonItem is! Map<String, dynamic>) {
            throw Exception(
                'Expected Map<String, dynamic> but got ${jsonItem.runtimeType}');
          }
          return fromJson(jsonItem);
        }));

        return objects;
      } catch (e) {
        throw Exception('Error during JSON decoding: $e');
      }
    }
  }
}