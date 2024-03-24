part of 'home_page.dart';

///Bottom sheet to edit product.
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

/// Form to update product.
Widget _buildFormUpdateProduct(HomeCtrl controller, int index) {
  return Form(
    key: controller.formKey,
    child: Obx(
      () => Column(
        children: [
          SizedBox(
            height: AppDimens.imagePicture,
            width: AppDimens.imagePicture,
            child: controller.listProducts[index].image == null ||
                    controller.listProducts[index].image == ""
                ? _buildImageProductEmpty()
                : Image.network(
                    controller.listProducts[index].image ?? "",
                  ),
          ),
          _buildInputField(
            label: HomeStr.name,
            textEditingController: controller.nameController,
            textValue: controller.name.value,
            maxlenght: 50,
          ),
          _buildInputField(
            label: HomeStr.sku,
            textEditingController: controller.skuController,
            textValue: controller.sku.value,
            maxlenght: 20,
          ),
          _buildInputField(
            label: HomeStr.color,
            textEditingController: controller.colorController,
            textValue: controller.color.value,
            validate: false,
          ),
        ],
      ),
    ),
  );
}

/// Build Input field to enter product information.
Widget _buildInputField({
  required String label,
  required TextEditingController textEditingController,
  required String textValue,
  String? hintText,
  bool validate = true,
  int? maxlenght,
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
          maxLengthInputForm: maxlenght,
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
            if ((value == null || value.isEmpty) && validate) {
              return HomeStr.pleaseEnterInfor;
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
