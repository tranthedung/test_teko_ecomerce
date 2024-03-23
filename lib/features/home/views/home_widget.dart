part of 'home_page.dart';

Widget _buildBody(HomeCtrl controller) {
  return Column(
    children: [
      _buildProducts(controller),
      // Row(
      //   children: [
      //     Expanded(
      //       child: ElevatedButton(
      //         onPressed: () {},
      //         child: Text("Submit"),
      //         style: ElevatedButton.styleFrom(
      //           backgroundColor: AppColors.colorsOrange,
      //           elevation: 0,
      //           shape: const RoundedRectangleBorder(
      //             borderRadius: BorderRadius.all(
      //               Radius.circular(AppDimens.radius8),
      //             ),
      //           ),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    ],
  );
}

Widget _buildProducts(HomeCtrl controller) {
  return Expanded(
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
  );
}

Widget _buildProductItem(HomeCtrl controller, int index) {
  return Container(
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(AppDimens.radius12),
      border: Border.all(color: AppColors.colorBasicGrey3),
    ),
    child: Obx(() {
      return Row(
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
                : Image.network(
                    controller.listProducts[index].image ?? "",
                    fit: BoxFit.cover,
                  ),
          ),
          Expanded(
            flex: 3,
            child: Column(
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
            ).paddingAll(AppDimens.paddingVerySmall),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
              onPressed: () {
                Get.bottomSheet(
                  isScrollControlled: true,
                  UtilWidget.baseBottomSheet(
                    title: "Chỉnh sửa sản phẩm",
                    body: _buildBottomSheetEdit(controller, index),
                    backgroundColor: AppColors.colorLightAccent,
                    noHeader: false,
                    height: Get.height * 0.8,
                  ),
                );
              },
              icon: Icon(Icons.edit),
            ),
          )
        ],
      );
    }),
  ).paddingAll(AppDimens.paddingSmallest);
}

Widget _buildText(String? content) {
  return Text(
    content ?? "",
    style: TextStyle(
      fontSize: AppDimens.sizeTextMediumTb,
      // fontFamily: GoogleFonts.nunito().fontFamily,
    ),
  );
}

Widget _buildBottomSheetEdit(
  HomeCtrl controller,
  int index,
) {
  return Column(
    children: [
      Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: [
              controller.listProducts[index].image == null ||
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
                  : Image.network(
                      controller.listProducts[index].image ?? "",
                      fit: BoxFit.cover,
                    ),
            ],
          ),
        ),
      ),
      BaseElevatedButton(
        "Cập nhật",
        () {},
        backgroundColor: AppColors.lightPrimaryColor,
        textColor: AppColors.white,
      )
    ],
  );
}
