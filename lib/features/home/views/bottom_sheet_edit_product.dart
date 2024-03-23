part of 'home_page.dart';

Widget _buildBottomSheetEdit(
  HomeCtrl controller,
  int index,
) {
  return Column(
    children: [
      Obx(
        () => Expanded(
          child: SingleChildScrollView(
            child: Form(
              key: controller.formKey,
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
                      : SizedBox(
                          height: AppDimens.imagePicture,
                          width: AppDimens.imagePicture,
                          child: Image.network(
                            controller.listProducts[index].image ?? "",
                            fit: BoxFit.cover,
                          ),
                        ),
                  _buildInputField(
                    label: "Name",
                    textEditingController: controller.nameController,
                    textValue: controller.name.value,
                  ),
                  _buildInputField(
                    label: "Sku",
                    textEditingController: controller.skuController,
                    textValue: controller.sku.value,
                  ),
                  _buildInputField(
                    label: "Color",
                    textEditingController: controller.colorController,
                    textValue: controller.color.value,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      BaseElevatedButton(
        "Update",
        () {
          controller.updateProduct(index);
        },
        backgroundColor: AppColors.lightPrimaryColor,
        textColor: AppColors.white,
      ),
    ],
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
