import 'dart:convert';

import 'package:ecomerce/base_utils/base_repository/base_request.dart';
import 'package:ecomerce/base_utils/controller_base/base_refresh_controller.dart';
import 'package:ecomerce/features/home/models/models_src.dart';
import 'package:ecomerce/features/home/repository/home_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeCtrl extends BaseRefreshGetxController {
  final RxList<ProductsModel> listProducts = <ProductsModel>[].obs;
  final Map<int, String> mapColors = <int, String>{};

  late HomeRepository homeRepository;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController skuController = TextEditingController();
  final TextEditingController colorController = TextEditingController();

  final RxString name = "".obs;
  final RxString sku = "".obs;
  final RxString color = "".obs;

  final formKey = GlobalKey<FormState>();

  @override
  void onInit() async {
    Get.put(BaseRequest(), permanent: true);
    homeRepository = HomeRepository(this);
    await getColors();
    await getProducts();
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
    for (var item in listProducts) {
      item.productColor = convertColor(item.color);
    }
  }

  /// Call api getColors to get list colors.
  Future<void> getColors() async {
    final listColors = await homeRepository.getColors();
    listColors.forEach(
      (element) {
        if (element.id != null && element.name != null) {
          mapColors[element.id!] = element.name!;
        }
      },
    );
  }

  String? convertColor(int? id) {
    if (id == null) {
      return null;
    } else {
      return mapColors[id];
    }
  }

  void getDataProduct(
    ProductsModel item,
  ) {
    nameController.text = item.name ?? "";
    skuController.text = item.sku ?? "";
    colorController.text = item.productColor ?? "";
  }

  void updateProduct(int index) {
    if (formKey.currentState!.validate()) {
      final ProductsModel item = listProducts[index];
      ProductsModel itemEdit = ProductsModel(
        id: item.id,
        errorDescription: item.errorDescription,
        name: nameController.text,
        sku: skuController.text,
        color: item.color,
        image: item.image,
        productColor: colorController.text,
      )..isEdited.value = true;
      listProducts[index] = itemEdit;
      Get.back();
    }
  }
}
