part of 'home_page.dart';

Widget _buildBody(HomeCtrl controller) {
  return Column(
    children: [
      _buildProducts(controller),
      _buildButtonSubmit(controller).paddingAll(AppDimens.paddingVerySmall),
    ],
  );
}

/// Show list products.
Widget _buildProducts(HomeCtrl controller) {
  return Obx(
    () => controller.listProducts.isEmpty
        ? const Expanded(
            child: Center(
              child: TextUtils(
                text: HomeStr.emptyList,
                availableStyle: StyleEnum.titleLarge,
              ),
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

/// Show popup when submit button is clicked.
Widget _buildButtonSubmit(HomeCtrl controller) {
  return BaseElevatedButton(
    HomeStr.submitButton,
    () {
      Get.dialog(
        _buildPopupProductsUpdated(controller),
      );
    },
    backgroundColor: AppColors.lightPrimaryColor,
    textColor: AppColors.white,
  );
}

/// Show product.
Widget _buildProductItem(HomeCtrl controller, int index) {
  return Container(
    decoration: BoxDecoration(
      color: controller.listProducts[index].isEdited.value
          ? AppColors.dsPrimaryBlueBlue.withOpacity(0.1)
          : AppColors.white,
      borderRadius: BorderRadius.circular(AppDimens.radius12),
      border: Border.all(
        color: AppColors.colorBasicGrey3,
      ),
    ),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: controller.listProducts[index].image == null ||
                  controller.listProducts[index].image == ""
              ? _buildImageProductEmpty()
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

Widget _buildImageProductEmpty() {
  return SvgPicture.asset(
    height: AppDimens.iconError,
    width: AppDimens.iconError,
    ImageAsset.iconError,
  );
}

Widget _buildImageProduct(HomeCtrl controller, int index) {
  return Image.network(
    controller.listProducts[index].image ?? "",
    fit: BoxFit.cover,
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
      _buildText(
        controller.listProducts[index].productColor,
      ),
    ],
  );
}

Widget _buildText(String? content) {
  return TextUtils(
    text: content ?? "",
    availableStyle: StyleEnum.bodyMedium,
    maxLine: 2,
  );
}

Widget _buildEditProduct(HomeCtrl controller, int index) {
  return IconButton(
    onPressed: () {
      controller.getDataProduct(controller.listProducts[index]);
      Get.bottomSheet(
        isScrollControlled: true,
        UtilWidget.baseBottomSheet(
          title: HomeStr.editProduct,
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
