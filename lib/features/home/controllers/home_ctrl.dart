import 'package:ecomerce/base_utils/base_repository/base_request.dart';
import 'package:ecomerce/base_utils/controller_base/base_refresh_controller.dart';
import 'package:ecomerce/features/home/models/models_src.dart';
import 'package:ecomerce/features/home/repository/home_repository.dart';
import 'package:get/get.dart';

class HomeCtrl extends BaseRefreshGetxController {
  RxList<ProductsModel> listProducts = <ProductsModel>[].obs;
  RxList<ColorsModel> listColors = <ColorsModel>[].obs;

  late HomeRepository homeRepository;

  @override
  void onInit() async {
    Get.put(BaseRequest(), permanent: true);
    homeRepository = HomeRepository(this);
    await getProducts();
    await getColors();
    super.onInit();
  }

  @override
  Future<void> onLoadMore() {
    // TODO: implement onLoadMore
    throw UnimplementedError();
  }

  @override
  Future<void> onRefresh() async {
    await getProducts();
    refreshController.refreshCompleted();
  }

  /// Call api getProduct to get list products.
  Future<void> getProducts() async {
    listProducts.value = await homeRepository.getProducts();
  }

  /// Call api getColors to get list colors.
  Future<void> getColors() async {
    listColors.value = await homeRepository.getColors();
  }
}
