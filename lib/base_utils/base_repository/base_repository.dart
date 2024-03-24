import 'package:dio/dio.dart';
import 'package:ecomerce/base_utils/base_repository/base_request.dart';
import 'package:ecomerce/base_utils/controller_base/base_controller.dart';
import 'package:get/get.dart';

class BaseRepository {
  final BaseRequest _baseRequest = Get.find<BaseRequest>();
  final BaseGetxController controller;

  BaseRepository(this.controller);

  Future<dynamic> baseSendRequest(
    String action,
    String requestMethod, {
    dynamic jsonMap,
    bool isDownload = false,
    String? urlOther,
    Map<String, String>? headersUrlOther,
    bool isQueryParametersPost = false,
    BaseOptions? dioOptions,
    bool isHaveVersion = true,
    Function(Object error)? functionError,
  }) {
    return _baseRequest.sendRequest(
      action,
      requestMethod,
      jsonMap: jsonMap,
      isDownload: isDownload,
      urlOther: urlOther,
      headersUrlOther: headersUrlOther,
      isQueryParametersPost: isQueryParametersPost,
      controller: controller,
      dioOptions: dioOptions,
      functionError: functionError,
      isHaveVersion: isHaveVersion,
    );
  }
}
