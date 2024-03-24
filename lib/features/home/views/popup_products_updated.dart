part of 'home_page.dart';

Widget _buildPopupProductsUpdated(HomeCtrl controller) {
  return Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(
        AppDimens.radius12,
      ),
    ),
    backgroundColor: AppColors.white,
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
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return _buildProductUpdatedItem(controller, index);
              },
              itemCount: controller.listProducts.length,
            ),
          ),
          Align(
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
          ),
        ],
      ),
    ).paddingAll(AppDimens.paddingVerySmall),
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
