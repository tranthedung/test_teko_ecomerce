part of 'home_page.dart';

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
      ),
    ],
  );
}
