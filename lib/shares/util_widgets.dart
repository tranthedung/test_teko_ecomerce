import 'package:ecomerce/core/values/colors.dart';
import 'package:ecomerce/core/values/dimens.dart';
import 'package:ecomerce/shares/text_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UtilWidget {
  static DateTime? _dateTime;
  static int _oldFunc = 0;

  static Widget buildLoading({
    Color? colorIcon,
  }) =>
      CupertinoActivityIndicator(
        color: colorIcon,
      );

  /// Loading cho child
  static Widget baseShowLoadingChild({
    required WidgetCallback child,
    required bool isShowLoading,
    Color? colorIcon,
  }) {
    return isShowLoading
        ? Expanded(child: Center(child: buildLoading()))
        : child();
  }

  /// Base smart refesher.
  static Widget buildSmartRefresher({
    required RefreshController refreshController,
    required Widget child,
    ScrollController? scrollController,
    Function()? onRefresh,
    Function()? onLoadMore,
    bool enablePullUp = false,
  }) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: enablePullUp,
      scrollController: scrollController,
      header: const MaterialClassicHeader(
        color: AppColors.colorLoading,
      ),
      controller: refreshController,
      onRefresh: onRefresh,
      onLoading: onLoadMore,
      footer: buildSmartRefresherCustomFooter(),
      child: child,
    );
  }

  static Widget buildSmartRefresherCustomFooter() {
    return CustomFooter(
      builder: (context, mode) {
        if (mode == LoadStatus.loading) {
          return const CupertinoActivityIndicator();
        } else {
          return const SizedBox();
        }
      },
    );
  }

  ///Base bottom sheet.
  static Widget baseBottomSheet({
    required String title,
    required Widget body,
    Widget? iconTitle,
    bool isSecondDisplay = false,
    Widget? actionArrowBack,
    double? padding,
    bool noHeader = false,
    Color? backgroundColor,
    TextAlign? textAlign,
    double? height,
  }) {
    return SafeArea(
      bottom: false,
      minimum: EdgeInsets.only(
          top: Get.mediaQuery.padding.top + (isSecondDisplay ? 100 : 20)),
      child: Container(
        height: height ?? Get.height / 3,
        padding: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.bottomSheet(),
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(AppDimens.defaultPadding),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Drag handle Icon
            Center(
              child: Container(
                height: AppDimens.paddingSmallest,
                width: AppDimens.iconLarge,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                      Radius.circular(AppDimens.defaultPadding)),
                  color: Colors.grey,
                ),
              ).paddingSymmetric(vertical: AppDimens.paddingSmaller),
            ),
            noHeader
                ? const SizedBox()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      actionArrowBack ??
                          const BackButton(
                            color: AppColors.colorGrey,
                          ),
                      Expanded(
                        child: TextUtils(
                          text: title.tr,
                          textAlign: textAlign ?? TextAlign.center,
                          maxLine: 1,
                          availableStyle: StyleEnum.titleMedium,
                          color: AppColors.colorTitleAppbar,
                        ),
                      ),
                      iconTitle ??
                          const SizedBox(
                            width: 48, //size of Back Button
                          ),
                    ],
                  ),
            Expanded(child: body),
          ],
        ).paddingSymmetric(horizontal: padding ?? AppDimens.defaultPadding),
      ),
    );
  }

  /// Base app bar
  static PreferredSizeWidget buildAppBar(String title,
      {Color? textColor,
      Color? actionsIconColor,
      Color? backButtonColor,
      Color? backgroundColor,
      bool centerTitle = false,
      double fontSize = 16,
      FontWeight fontWeight = FontWeight.w400,
      Function()? funcLeading,
      bool leading = true,
      List<Widget>? actions,
      bool isColorGradient = false,
      List<Color>? colorTransparent,
      TabBar? widget,
      Widget? titleWidget,
      bool statusBarIconBrightness = false}) {
    return AppBar(
      bottom: widget,
      actionsIconTheme:
          IconThemeData(color: actionsIconColor ?? AppColors.white),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness:
            statusBarIconBrightness ? Brightness.dark : Brightness.light,
        statusBarIconBrightness:
            statusBarIconBrightness ? Brightness.light : Brightness.dark,
      ),
      title: titleWidget ??
          UtilWidget.buildAppBarTitle(
            title,
            textColor: textColor ?? AppColors.colorTextDefault,
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
      automaticallyImplyLeading: false,
      centerTitle: centerTitle,
      leading: !leading
          ? null
          : UtilWidget.baseOnAction(
              onTap: () {
                if (funcLeading != null) {
                  funcLeading();
                } else {
                  Get.back();
                }
              },
              child: IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.chevron_left,
                  color: backButtonColor ?? AppColors.colorBasicBlack,
                  size: AppDimens.iconMedium,
                ),
              ),
            )
      /*BackButton(
              color: backButtonColor ?? AppColors.textColorDefault,
              onPressed: funcLeading,
            )*/
      ,
      flexibleSpace: isColorGradient
          ? Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.bottomRight,
                  colors: colorTransparent ??
                      <Color>[
                        AppColors.colorBackgroundLight,
                        AppColors.colorBackgroundLight,
                      ],
                ),
              ),
            )
          : null,
      actions: actions,
      backgroundColor:
          isColorGradient ? null : backgroundColor ?? AppColors.white,
      titleSpacing: titleWidget == null ? null : 0,
    );
  }

  static buildAppBarTitle(
    String title, {
    bool? textAlignCenter,
    Color? textColor,
    double? fontSize,
    FontWeight? fontWeight,
  }) {
    textAlignCenter = textAlignCenter ?? GetPlatform.isAndroid;
    return TextUtils(
      text: title.tr,
      availableStyle: StyleEnum.titleMedium,
      textAlign: textAlignCenter ? TextAlign.center : TextAlign.left,
      fontWeight: fontWeight,
      size: fontSize,
      color: textColor,
    );
  }

  static Widget baseOnAction({
    required Function onTap,
    required Widget child,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        DateTime now = DateTime.now();
        if (_dateTime == null ||
            now.difference(_dateTime ?? DateTime.now()) > 2.seconds ||
            onTap.hashCode != _oldFunc) {
          _dateTime = now;
          _oldFunc = onTap.hashCode;
          onTap();
        }
      },
      child: child,
    );
  }

  /// Sử dụng để tránh trường hợp click liên tiếp khi thực hiện function
  static VoidCallback? baseOnTap(VoidCallback? onTap) {
    return (() {
      DateTime now = DateTime.now();
      if (_dateTime == null ||
          now.difference(_dateTime ?? DateTime.now()) > 2.seconds ||
          onTap.hashCode != _oldFunc) {
        _dateTime = now;
        _oldFunc = onTap.hashCode;
        onTap?.call();
      }
    });
  }
}
