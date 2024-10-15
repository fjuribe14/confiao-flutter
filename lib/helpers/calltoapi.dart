import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:confiao/helpers/index.dart';

class CallToApi {
  CallToApi._internal(); //singleton constructor privado
  static final CallToApi _instance = CallToApi._internal();

  static CallToApi get instance => _instance;

  Future<Dio> httpService = Http().http();

  Future get(String endpoint,
      {Map<String, dynamic>? queryParameters,
      bool showLoading = true,
      Map<String, dynamic>? body}) async {
    httpService = Http().http(showLoading: showLoading);

    return await httpService.then((value) {
      if (queryParameters != null) {
        value.options.queryParameters = queryParameters;
      }
      return value.get(
        endpoint,
        queryParameters: queryParameters,
        data: body,
      );
    });
  }

  Future post(String endpoint,
      {required Map<String, dynamic> data,
      Map<String, dynamic>? queryParameters,
      bool showLoading = true}) async {
    httpService = Http().http(showLoading: showLoading);

    return await httpService.then(
      (value) {
        value.options.queryParameters = queryParameters ?? {};
        return value.post(
          endpoint,
          data: jsonEncode(data),
          queryParameters: queryParameters,
        );
      },
    );
  }

  Future put(String endpoint,
      {required Map<String, dynamic> data,
      Map<String, dynamic>? queryParameters,
      bool showLoading = true}) async {
    httpService = Http().http(showLoading: showLoading);

    return await httpService.then(
      (value) {
        value.options.queryParameters = queryParameters ?? {};

        return value.put(
          endpoint,
          data: jsonEncode(data),
          queryParameters: queryParameters ?? {},
        );
      },
    );
  }

  Future delete(String endpoint,
      {required Map<String, dynamic> data,
      Map<String, dynamic>? queryParameters,
      bool showLoading = true}) async {
    httpService = Http().http(showLoading: showLoading);

    return await httpService.then(
      (value) {
        value.options.queryParameters = queryParameters ?? {};

        return value.delete(
          endpoint,
          data: jsonEncode(data),
          queryParameters: queryParameters ?? {},
        );
      },
    );
  }
}
