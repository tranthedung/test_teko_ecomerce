import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:ecomerce/base_utils/controller_base/base_controller.dart';
import 'package:ecomerce/core/enum/enum_request_method.dart';
import 'package:ecomerce/core/values/app_url.dart';
import 'package:ecomerce/core/values/const.dart';

class BaseRequest {
  static Dio dio = getBaseDio();

  static Dio getBaseDio() {
    Dio dio = Dio();

    dio.options = buildDefaultOptions();

    dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final client = HttpClient();
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      },
    );
    return dio;
  }

  static BaseOptions buildDefaultOptions() {
    return BaseOptions()
      ..connectTimeout = const Duration(milliseconds: AppConst.requestTimeOut)
      ..receiveTimeout = const Duration(milliseconds: AppConst.requestTimeOut);
  }

  static void close() {
    dio.close(force: true);
    updateCurrentDio();
  }

  static void updateCurrentDio() {
    dio = getBaseDio();
  }

  static Dio getCurrentDio() {
    return dio;
  }

  void setOnErrorListener(Function(Object error) onErrorCallBack) {
    this.onErrorCallBack = onErrorCallBack;
  }

  late Function(Object error) onErrorCallBack;

  Future<dynamic> sendRequest(
    String action,
    String requestMethod, {
    dynamic jsonMap,
    bool isDownload = false,
    String? urlOther,
    Map<String, String>? headersUrlOther,
    bool isQueryParametersPost = false,
    required BaseGetxController controller,
    BaseOptions? dioOptions,
    Function(Object error)? functionError,
    bool isToken = false,
    bool isHaveVersion = true,
  }) async {
    dio.options = dioOptions ?? buildDefaultOptions();
    dynamic response;
    String url = urlOther ??
        (AppUrl.url + action + (isHaveVersion ? AppUrl.version : ""));
    Map<String, String> headers = {"Content-Type": "application/json"};
    Options options = isDownload
        ? Options(
            headers: headers,
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return status != null && status < 500;
            })
        : Options(
            headers: headers,
            responseType: ResponseType.json,
          );
    CancelToken cancelToken = CancelToken();
    controller.addCancelToken(cancelToken);
    try {
      if (requestMethod == EnumRequestMethod.post) {
        if (isQueryParametersPost) {
          response = await dio.post(
            url,
            queryParameters: jsonMap,
            options: options,
            cancelToken: cancelToken,
          );
        } else {
          response = await dio.post(
            url,
            data: jsonMap,
            options: options,
            cancelToken: cancelToken,
          );
        }
      } else if (requestMethod == EnumRequestMethod.delete) {
        response = await dio.delete(
          url,
          data: jsonMap,
          options: options,
          cancelToken: cancelToken,
        );
      } else if (requestMethod == EnumRequestMethod.put) {
        response = await dio.put(
          url,
          data: jsonMap,
          options: options,
          cancelToken: cancelToken,
        );
      } else {
        response = await dio.get(
          url,
          queryParameters: jsonMap,
          options: options,
          cancelToken: cancelToken,
        );
      }
      return response.data;
    } catch (e) {
      controller.cancelRequest(cancelToken);
      return functionError != null ? functionError(e) : showDialogError(e);
    }
  }

  dynamic showDialogError(dynamic e) {
    if (e.response?.data != null &&
        e.response.data is Map &&
        e.response.data["errorMessage"] != null) return e.response.data;
    onErrorCallBack(e);
  }
}
