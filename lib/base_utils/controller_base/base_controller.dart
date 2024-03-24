import 'package:dio/dio.dart';
import 'package:get/get.dart';

class BaseGetxController extends GetxController {
  RxBool isShowLoading = false.obs;
  String errorContent = '';
  RxBool isRemember = false.obs;
  List<CancelToken> cancelTokens = [];

  RxBool isLoadingOverlay = false.obs;

  void showLoading() {
    isShowLoading.value = true;
  }

  void hideLoading() {
    isShowLoading.value = false;
  }

  void showLoadingOverlay() {
    isLoadingOverlay.value = true;
  }

  void hideLoadingOverlay() {
    isLoadingOverlay.value = false;
  }

  void addCancelToken(CancelToken cancelToken) {
    cancelTokens.add(cancelToken);
  }

  void cancelRequest(CancelToken cancelToken) {
    if (!cancelToken.isCancelled) {
      cancelToken.cancel('Cancel when close controller!!!');
    }
  }
}
