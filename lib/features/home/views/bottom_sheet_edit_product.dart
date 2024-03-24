part of 'home_page.dart';

Widget _buildBottomSheetEdit(
  HomeCtrl controller,
  int index,
) {
  return Column(
    children: [
      Expanded(
        child: SingleChildScrollView(
          child: _buildFormUpdateProduct(controller, index),
        ),
      ),
      BaseElevatedButton(
        HomeStr.updateButton,
        () {
          controller.updateProduct(index);
        },
        backgroundColor: AppColors.lightPrimaryColor,
        textColor: AppColors.white,
      ),
    ],
  );
}

Widget _buildFormUpdateProduct(HomeCtrl controller, int index) {
  return Form(
    key: controller.formKey,
    child: Obx(
      () => Column(
        children: [
          controller.listProducts[index].image == null ||
                  controller.listProducts[index].image == ""
              ? _buildImageProductEmpty()
              : SizedBox(
                  height: AppDimens.imagePicture,
                  width: AppDimens.imagePicture,
                  child: Image.network(
                    controller.listProducts[index].image ?? "",
                    fit: BoxFit.cover,
                  ),
                ),
          _buildInputField(
            label: HomeStr.name,
            textEditingController: controller.nameController,
            textValue: controller.name.value,
          ),
          _buildInputField(
            label: HomeStr.sku,
            textEditingController: controller.skuController,
            textValue: controller.sku.value,
          ),
          _buildInputField(
            label: HomeStr.color,
            textEditingController: controller.colorController,
            textValue: controller.color.value,
          ),
        ],
      ),
    ),
  );
}

Widget _buildInputField({
  required String label,
  required TextEditingController textEditingController,
  required String textValue,
  String? hintText,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      TextUtils(
        text: label,
        availableStyle: StyleEnum.titleMedium,
        color: AppColors.colorBasicGrey,
      ),
      UtilWidget.sizedBox5,
      BuildInputText(
        InputTextModel(
          controller: textEditingController,
          textColor: AppColors.colorBasicBlack,
          hintText: hintText,
          hintTextColor: AppColors.colorBasicGrey2,
          hintTextSize: AppDimens.sizeTextSmall,
          colorBorder: AppColors.colorBasicGrey2,
          fillColor: AppColors.colorWhite,
          onChanged: (value) {
            textValue = value;
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Vui lòng nhập đầy đủ thông tin";
            }
            return null;
          },
        ),
      ),
      UtilWidget.sizedBox5,
    ],
  ).paddingSymmetric(
    vertical: AppDimens.paddingSmallest,
  );
}
