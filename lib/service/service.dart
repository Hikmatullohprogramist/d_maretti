import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:d_maretti/models/statistic_model.dart';
import 'package:flutter/foundation.dart';

class ApiService {
  late String baseUrl;
  late BaseOptions options;
  late Dio dio;

  ApiService() {
    baseUrl = "http://dmaretti.jprq.site:80/";
    options = BaseOptions(baseUrl: baseUrl);
    dio = Dio(options);
  }

  Future<HisobotModel> getUser(String date) async {
    try {
      final Response<String> response =
          await dio.get("showStatistic?vaqt=$date");
      if (kDebugMode) {
        print(date);
      }
      if (response.statusCode == 200) {
        final String responseBody = response.data!;
        final dynamic jsonData = json.decode(responseBody);

        if (jsonData is Map<String, dynamic>) {
          print(jsonData);
          return HisobotModel.fromJson(jsonData);

        } else {
          if (kDebugMode) {
            print("Invalid JSON response");
          }
        }
      } else {
        if (kDebugMode) {
          print("Request failed with status code: ${response.statusCode}");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    }

    // Return a default HisobotModel if there's an error or invalid JSON.
    return HisobotModel(
      naqd: "0",
      plastik: "0",
      chiqimNaqd: "0",
      chiqimPlastik: "0",
      haridorNaqd: "0",
      haridorPlastik: "0",
      vozvratNaqd: "0",
      vozvratPlastik: '0',
    );
  }
}
