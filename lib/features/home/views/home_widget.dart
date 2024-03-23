part of 'home_page.dart';

Widget _buildBody(HomeCtrl controller) {
  return Column(
    children: [
      _buildProducts(controller),
      BaseElevatedButton(
        "Cập nhật",
        () {},
        backgroundColor: AppColors.lightPrimaryColor,
        textColor: AppColors.white,
      ).paddingAll(AppDimens.paddingVerySmall),
    ],
  );
}

Widget _buildProducts(HomeCtrl controller) {
  return Obx(
    () => controller.listProducts.isEmpty
        ? const Expanded(
            child: Center(
              child: Text("Danh sách trống"),
            ),
          )
        : Expanded(
            child: UtilWidget.buildSmartRefresher(
              refreshController: controller.refreshController,
              enablePullUp: true,
              // onLoadMore: controller.onLoadMore(),
              onRefresh: controller.onRefresh,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return _buildProductItem(controller, index);
                },
                itemCount: controller.listProducts.length,
              ),
            ),
          ),
  );
}

Widget _buildProductItem(HomeCtrl controller, int index) {
  return Container(
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(AppDimens.radius12),
      border: Border.all(color: AppColors.colorBasicGrey3),
    ),
    child: Row(
      children: [
        Expanded(
          flex: 1,
          child: controller.listProducts[index].image == null ||
                  controller.listProducts[index].image == ""
              ? Container(
                  color: AppColors.colorBasicGrey3,
                  child: const Center(
                    child: Text(
                      "No Image",
                      style: TextStyle(
                        fontSize: AppDimens.sizeTextMediumTb,
                      ),
                    ),
                  ),
                )
              : _buildImageProduct(controller, index),
        ),
        Expanded(
          flex: 3,
          child: _buildInforProduct(controller, index)
              .paddingAll(AppDimens.paddingVerySmall),
        ),
        Expanded(
          flex: 1,
          child: _buildEditProduct(controller, index),
        )
      ],
    ),
  ).paddingAll(AppDimens.paddingSmallest);
}

Widget _buildImageProduct(HomeCtrl controller, int index) {
  return Image.network(
    controller.listProducts[index].image ?? "",
    fit: BoxFit.cover,
  );
}

Widget _buildText(String? content) {
  return TextUtils(
    text: content ?? "",
    availableStyle: StyleEnum.bodyMedium,
  );
}

Widget _buildInforProduct(HomeCtrl controller, int index) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildText(
        controller.listProducts[index].name,
      ),
      _buildText(
        controller.listProducts[index].errorDescription,
      ),
      _buildText(
        controller.listProducts[index].sku,
      ),
      // _buildText(
      //   controller.listProducts[index].color,
      // ),
    ],
  );
}

Widget _buildEditProduct(HomeCtrl controller, int index) {
  return IconButton(
    onPressed: () {
      controller.getDataProduct(controller.listProducts[index]);
      Get.bottomSheet(
        isScrollControlled: true,
        UtilWidget.baseBottomSheet(
          title: "Chỉnh sửa sản phẩm",
          body: _buildBottomSheetEdit(controller, index),
          backgroundColor: AppColors.colorLightAccent,
          noHeader: false,
          height: Get.height,
        ),
      );
    },
    icon: const Icon(
      Icons.edit,
      color: AppColors.colorAttention,
    ),
  );
}
