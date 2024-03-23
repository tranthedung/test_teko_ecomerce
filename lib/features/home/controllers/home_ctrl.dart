import 'package:ecomerce/base_utils/controller_base/base_refresh_controller.dart';
import 'package:ecomerce/features/home/models/products_model.dart';
import 'package:ecomerce/features/home/repository/home_repository.dart';
import 'package:get/get.dart';

class HomeCtrl extends BaseRefreshGetxController {
  RxList<ProductsModel> listProducts = <ProductsModel>[].obs;

  late HomeRepository homeRepository;

  @override
  void onInit() async {
    homeRepository = HomeRepository(this);
    await getProducts();
    super.onInit();
  }

  @override
  Future<void> onLoadMore() {
    // TODO: implement onLoadMore
    throw UnimplementedError();
  }

  @override
  Future<void> onRefresh() {
    // TODO: implement onRefresh
    throw UnimplementedError();
  }

  Future<void> getProducts() async {
    listProducts.value = await homeRepository.getProducts();
  }
}
