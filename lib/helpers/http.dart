import 'dart:convert';
import 'dart:developer';
import 'package:confiao/controllers/auth/auth_ctrl.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:confiao/helpers/index.dart';
// import 'package:confiao/controllers/index.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Http {
  var alertService = AlertService();

  Future<Dio> http({bool showLoading = true}) async {
    var dio = Dio();
    // final Map<String, CancelToken> pendingRequests = {};

    dio.options.contentType = "application/json";
    dio.options.headers = {"Accept": "application/json"};
    // dio.options.connectTimeout = const Duration(minutes: 1);

    // void cancelAll() {
    //   pendingRequests.forEach((url, token) => token.cancel());
    //   pendingRequests.clear();
    // }

    dio.interceptors.add(
      QueuedInterceptorsWrapper(
        onRequest: (options, handler) async {
          final requestOptions = RequestOptions(path: options.path);
          final cancelToken = CancelToken();
          requestOptions.cancelToken = cancelToken;
          // pendingRequests[options.path] = cancelToken;

          if (showLoading) {
            alertService.showLoading(true);
          }

          if (kDebugMode) {
            log('REQ TO PATH => ${options.path}');
            log('http queryParameters: ${jsonEncode(options.queryParameters)}');
            // log('http data: ${options.data}');
          }

          final token = await getTokenLocaly();

          // if (['', null, 'null', ' '].contains(token) &&
          //     ![
          //       ApiUrl.authLogin,
          //       ApiUrl.apiComunesTasaValor,
          //       ApiUrl.apiComunesParticipantes,
          //       ApiUrl.apiRestEndPointPasswordReset,
          //       ApiUrl.apiRestEndPointActivateRegister,
          //       ApiUrl.apiRestEndPointResentCodeRegister,
          //       ApiUrl.apiRestEndPointPasswordResetRequest,
          //       ApiUrl.apiRestEndPointRegisterDeviceRecent,
          //       ApiUrl.apiRestEndPointPasswordResetValidate,
          //     ].contains(options.path)) {
          //   // await exit();
          //   return handler.reject(
          //     DioException.requestCancelled(
          //         requestOptions: requestOptions,
          //         reason: 'cancelled not token provide'),
          //   );
          // } else {
          log(jsonEncode({"Authorization": 'Bearer $token'}));
          options.headers.addAll({"Authorization": 'Bearer $token'});
          // }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          // pendingRequests.remove(response.requestOptions.path);

          if (kDebugMode) {
            log('RESP FROM PATH => ${response.statusCode} :: ${response.requestOptions.path}');
            log('DATA FROM PATH => ${response.data}');
          }

          if (showLoading) {
            alertService.showLoading(false);
          }

          return handler.next(response);
        },
        onError: (DioException err, ErrorInterceptorHandler handler) async {
          // pendingRequests.remove(err.requestOptions.path);

          // HandleErrors handleErrors = HandleErrors();

          // handleErrors.setMetadataLogAndErrorTrace(
          //     key: 'status_code', value: "${err.response?.statusCode}");

          if (kDebugMode) {
            log('ERROR FROM PATH => ${err.requestOptions.path}');
            log('cod: ${err.response?.statusCode} >> message: ${err.response?.data}');
          }

          if (showLoading) {
            alertService.showLoading(false);
          }

          switch (err.response?.statusCode) {
            case 400:
              if (err.response?.data['success'] != null &&
                  !Get.isSnackbarOpen) {
                alertService.showSnackBar(
                  title: "${err.response?.data['success']}",
                  body: '${err.response?.data['message']}',
                );
              }

              break;
            case 401:
              if (err.response?.data['message'] == 'No valid token provided' &&
                  !Get.isSnackbarOpen) {
                alertService.showSnackBar(
                  title: "Error: ${err.response?.statusCode}",
                  body: 'Por favor acceda nuevamente con su contraseña',
                );
              }

              // cancelAll();

              await exit();

              break;
            case 403:
              if (['false', false].contains(err.response?.data['available']) &&
                  !Get.isSnackbarOpen) {
                alertService.showSnackBar(
                  title: "${err.response?.data['error']}",
                  body: 'Por favor acceda nuevamente con su contraseña',
                );
              }
              // cancelAll();

              await exit();

              break;
            case 404:
              if (![null, '', ' '].contains(err.response?.data) &&
                  err.response?.data?['error'] != null &&
                  err.response?.data?['message'] != null &&
                  !Get.isSnackbarOpen) {
                alertService.showSnackBar(
                  title: "Error: ${err.response?.data?['error']}",
                  body: err.response?.data['message'],
                );
              }
              break;
            case 409:
              if (![null, '', ' '].contains(err.response?.data) &&
                  err.response?.data['error'] != null &&
                  err.response?.data['message'] != null &&
                  !Get.isSnackbarOpen) {
                alertService.showSnackBar(
                  title: "Error: ${err.response?.data?['error']}",
                  body: err.response?.data['message'],
                );
              }
              break;
            case 422:
              if (err.response?.data['message'] ==
                      'The given data was invalid.' &&
                  (err.response?.data?['errors']?['username']?.length ?? 0) >
                      0 &&
                  !Get.isSnackbarOpen) {
                alertService.showSnackBar(
                  title: "El usuario ya esta registrado o es inválido",
                  body: 'Verifíquelo o intentar recuperar su contraseña.',
                );
              } else if (err.response?.data['errors'] != null &&
                  !Get.isSnackbarOpen) {
                String body = '';
                err.response?.data['errors'].forEach((key, value) {
                  body = '$body $key \n ${value.join("\n")}';
                });

                alertService.showSnackBar(
                  title: "Error: ${err.response?.statusCode}",
                  body: 'Los datos proporcionados no son validos \n'
                      '${err.response?.data['message']}\n $body',
                );
              } else if (err.response?.data['error'] != null &&
                  err.response?.data['message'] != null &&
                  !Get.isSnackbarOpen) {
                alertService.showSnackBar(
                  title: "${err.response?.data['error']}",
                  body: err.response?.data['message'],
                );
              } else {
                break;
              }
              break;
            case 500:
              debugPrint(
                'ERROR FROM PATH => ${err.requestOptions.path}\ncod: '
                '${err.response?.statusCode} >> message: ${err.response?.data}',
              );

              // handleErrors.setMetadataLogAndErrorTrace(
              //     key: 'URI',
              //     value: err.requestOptions.path,
              //     log:
              //         'ERROR FROM PATH => ${err.requestOptions.path}\n cod: ${err.response?.statusCode} >> message: ${err.response?.data}');

              bool isNotFinded = err.response?.data?['message']
                      .toString()
                      .contains('No query results') ??
                  false;

              if (isNotFinded && !Get.isSnackbarOpen) {
                alertService.showSnackBar(
                  title: "No existen las coincidencias.",
                  body: 'Por favor Verifíca e inténtalo de nuevo.',
                );
              } else if (['', ' ', null]
                      .contains(err.response?.data?['monto'].toString()) ||
                  [false, 'false', 0].contains(err.response?.data?['status']) &&
                      !Get.isSnackbarOpen) {
                alertService.showSnackBar(
                  title: "Error",
                  body: '${err.response?.data['mensaje']}',
                );
              } else if (err.response?.data['errors'] != null &&
                  !Get.isSnackbarOpen) {
                alertService.showSnackBar(
                  title: "Error",
                  body: '${err.response?.data['errors']?[0]}',
                );
              }
              break;
            case null:
              if (err.type != DioExceptionType.cancel && !Get.isSnackbarOpen) {
                alertService.showSnackBar(
                  title: "Hemos detectado problemas de comunicación.",
                  body:
                      'Verifique su conexión a internet e inténtalo nuevamente.',
                );
              }
              break;

            default:
              // handleErrors.setMetadataLogAndErrorTrace(
              //     key: 'URI',
              //     value: err.requestOptions.path,
              //     log:
              //         'ERROR FROM PATH => ${err.requestOptions.path}\n cod: ${err.response?.statusCode} >> message: ${err.response?.data}');

              if (!Get.isSnackbarOpen) {
                alertService.showSnackBar(
                  title: "oops, ${"error_ocurred".tr},\n ${"try_again".tr}",
                  body: '${err.response?.statusCode}',
                  duration: 10,
                );
              }
              // alertService.showLoading(false);
              break;
          }
          if (kDebugMode) {
            alertService.showSnackBar(
              title: "<<>>DeBuG ErRoR COD: ${err.response?.statusCode}",
              body: "${err.response?.data.toString()}",
              // backgroundColor: ColorTheme.primary,
              // colorText: ColorTheme.light,
            );
          }
          return handler.next(err);
        },
      ),
    );

    return dio;
  }

  getTokenLocaly() async {
    FlutterSecureStorage secureStorage = const FlutterSecureStorage();

    dynamic data = await secureStorage.read(
      key: StorageKeys.storageItemUserToken,
    );

    if (data != null) {
      return data;
    } else {
      if (kDebugMode) {
        debugPrint('getTokenLocaly: not token');
      }
      return null;
    }
  }

  exit() async {
    await AuthCtrl().logout();
  }
}
