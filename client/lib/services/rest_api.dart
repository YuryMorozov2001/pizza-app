import 'dart:io';

import 'package:dio/dio.dart';
import '../const/const.dart';
import '../model/pizza.dart';

class RestApi {
  final _api = Dio(
    BaseOptions(baseUrl: url, headers: {
      'Content-Type': ContentType.json.mimeType,
    }),
  );

  Future<List<Pizza>?> getPizzaList() async {
    final request = await _api.get('');
    final result = request.data as List<dynamic>;
    return result.map((e) => Pizza.fromMap(e)).toList();
  }
}
