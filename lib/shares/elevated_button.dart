import 'package:ecomerce/core/values/colors.dart';
import 'package:ecomerce/core/values/dimens.dart';
import 'package:ecomerce/shares/text_utils.dart';
import 'package:ecomerce/shares/util_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseElevatedButton extends StatelessWidget {
  final Function() function;
  final String btnTitle;
  final Widget? childBtn;
  final Color? backgroundColor;
  final bool isLoading;
  final bool showLoading;
  final double? width;
  final double? height;
  final BorderRadiusGeometry? borderRadius;
  final Color? textColor;
  final bool isBottom;
  final AlignmentGeometry? alignment;
  final MainAxisAlignment? mainAxisAlignment;
  final double? fontSize;
  final Widget? icon;

  final ButtonStyle? style;
  final FontWeight? fontWeight;
  final double? iconSize;
  final bool isCategory;
  final Color? borderColor;
  final BorderRadiusGeometry? innerBorderRadius;
  final int? maxLines;
  final TextAlign? textAlign;
  final bool isRightButton;
  final bool isDelayTap;

  const BaseElevatedButton(
    this.btnTitle,
    this.function, {
    Key? key,
    this.childBtn,
    this.backgroundColor = AppColors.colorsOrange,
    this.width,
    this.height,
    this.borderRadius,
    this.textColor,
    this.isLoading = false,
    this.showLoading = true,
    this.isBottom = true,
    this.alignment,
    this.mainAxisAlignment,
    this.fontSize,
    this.icon,
    this.style,
    this.fontWeight,
    this.iconSize,
    this.isCategory = false,
    this.borderColor,
    this.innerBorderRadius,
    this.maxLines,
    this.textAlign,
    this.isRightButton = false,
    this.isDelayTap = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height ?? AppDimens.btnDefault,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius ??
            BorderRadius.circular(
              AppDimens.iconMedium,
            ),
      ),
      child: _buildStyleBtn(),
    )..paddingOnly(
        bottom: isBottom
            ? GetPlatform.isIOS
                ? AppDimens.sizeTextLarge
                : AppDimens.paddingSmall
            : 0,
      );
  }

  Widget _buildStyleBtn() {
    return ElevatedButton(
      onPressed: !isLoading
          ? isDelayTap
              ? UtilWidget.baseOnTap(function)
              : function
          : () {},
      style: _btnStyle(),
      child: Stack(
        alignment: alignment ?? Alignment.center,
        children: [
          _buildViewBtn(),
          _buildLoading(),
        ],
      ),
    );
  }

  ButtonStyle? _btnStyle() {
    if (isCategory) {
      MaterialStateProperty<Color?>? color = MaterialStateProperty.all<Color?>(
        backgroundColor,
      );
      MaterialStateProperty<EdgeInsetsGeometry?>? padding =
          MaterialStateProperty.all<EdgeInsetsGeometry?>(
        EdgeInsets.zero,
      );
      return ButtonStyle(
        backgroundColor: color,
        overlayColor: color,
        shadowColor: color,
        padding: padding,
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: innerBorderRadius ?? BorderRadius.circular(8.0),
            side: BorderSide(
              color: borderColor ?? AppColors.lightPrimaryColor,
            ),
          ),
        ),
      );
    }

    return style ??
        ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ??
                BorderRadius.circular(
                  AppDimens.paddingVerySmall,
                ),
          ),
        );
  }

  Widget _buildViewBtn() {
    return childBtn ??
        Row(
          mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
          children: [
            Visibility(
              visible: !isRightButton,
              child: _buildIconLeading(),
            ),
            Flexible(
              child: TextUtils(
                text: btnTitle.tr,
                textAlign: textAlign ?? TextAlign.center,
                availableStyle: StyleEnum.titleMedium,
                fontWeight: fontWeight,
                maxLine: maxLines ?? 1,
                color: textColor ?? AppColors.white,
              ),
            ),
            Visibility(
              visible: isRightButton,
              child: _buildIconLeading(),
            ),
          ],
        );
  }

  Widget _buildLoading() {
    return Align(
      alignment: Alignment.centerRight,
      child: Visibility(
        visible: isLoading && showLoading,
        child: const SizedBox(
          height: AppDimens.btnSmall,
          width: AppDimens.btnSmall,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            backgroundColor: Colors.white,
            valueColor: AlwaysStoppedAnimation<Color>(
              AppColors.colorAttention,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIconLeading() {
    return Visibility(
      visible: icon != null,
      child: (icon ?? const SizedBox()).paddingOnly(
        right: AppDimens.paddingVerySmall,
      ),
    );
  }
}
