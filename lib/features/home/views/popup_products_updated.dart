part of 'home_page.dart';

/// Popup to show products updated.
Widget _buildPopupProductsUpdated(HomeCtrl controller) {
  return Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(
        AppDimens.radius12,
      ),
    ),
    backgroundColor: AppColors.colorLightAccent,
    child: SizedBox(
      width: Get.width,
      height: Get.height * 0.65,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextUtils(
            text: HomeStr.submitChanges,
            availableStyle: StyleEnum.titleLarge,
          ),
          UtilWidget.sizedBox5,
          _buildListProductsEdited(controller),
          _buildButonOk(),
        ],
      ),
    ).paddingAll(AppDimens.paddingVerySmall),
  );
}

/// List products updated.
Widget _buildListProductsEdited(HomeCtrl controller) {
  return Expanded(
    child: ListView.builder(
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.colorWhite,
            borderRadius: BorderRadius.circular(
              AppDimens.radius12,
            ),
          ),
          child: _buildProductUpdatedItem(controller, index),
        ).paddingSymmetric(vertical: AppDimens.paddingVerySmall);
      },
      itemCount: controller.listProducts.length,
    ),
  );
}

Widget _buildProductUpdatedItem(HomeCtrl controller, int index) {
  return Row(
    children: [
      Expanded(
        child: controller.listProducts[index].image == null ||
                controller.listProducts[index].image == ""
            ? _buildImageProductEmpty()
            : _buildImageProduct(controller, index),
      ),
      Expanded(
        flex: 2,
        child: _buildInforProduct(controller, index),
      ),
    ],
  );
}

/// Button ok in the bottom sheet edit product.
Widget _buildButonOk() {
  return Align(
    alignment: Alignment.centerRight,
    child: TextButton(
      onPressed: () {
        Get.back();
      },
      child: const TextUtils(
        text: HomeStr.okButton,
        color: AppColors.lightPrimaryColor,
        size: AppDimens.sizeTextLarge,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
