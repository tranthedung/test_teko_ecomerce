import 'package:ecomerce/core/values/colors.dart';
import 'package:ecomerce/core/values/dimens.dart';
import 'package:ecomerce/shares/input_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuildInputText extends StatefulWidget {
  final InputTextModel inputTextFormModel;

  const BuildInputText(this.inputTextFormModel, {Key? key}) : super(key: key);

  @override
  BuildInputTextState createState() => BuildInputTextState();
}

class BuildInputTextState extends State<BuildInputText> {
  final RxBool _isShowButtonClear = false.obs;
  final RxBool _showPassword = false.obs;

  @override
  void initState() {
    widget.inputTextFormModel.controller.addListener(() {
      if (widget.inputTextFormModel.controller.text.isNotEmpty) {
        _isShowButtonClear.value = true;
      }
    });
    _showPassword.value = widget.inputTextFormModel.obscureText;
    super.initState();
  }

  Widget? _suffixIconSearch() {
    return IconButton(
      onPressed: _isShowButtonClear.value
          ? () {
              widget.inputTextFormModel.controller.clear();
              widget.inputTextFormModel.onChanged?.call('');
              _isShowButtonClear.value = false;
            }
          : widget.inputTextFormModel.functionSearch,
      icon: _isShowButtonClear.value
          ? const Icon(Icons.cancel)
          : const Icon(Icons.search),
      padding: const EdgeInsets.all(10),
      constraints: const BoxConstraints(),
    );
  }

  Widget? _suffixIcon() {
    if (widget.inputTextFormModel.suffixIcon != null) {
      return widget.inputTextFormModel.suffixIcon;
    }
    if (!_isShowButtonClear.value || widget.inputTextFormModel.isReadOnly) {
      return null;
    }
    return widget.inputTextFormModel.obscureText
        ? IconButton(
            onPressed: () {
              _showPassword.toggle();
            },
            icon: _showPassword.value
                ? const Icon(Icons.remove_red_eye_outlined)
                : const Icon(Icons.remove_red_eye),
          )
        : Visibility(
            visible: _isShowButtonClear.value &&
                !widget.inputTextFormModel.isReadOnly,
            child: IconButton(
              onPressed: () {
                widget.inputTextFormModel.controller.clear();
                widget.inputTextFormModel.onChanged?.call('');
                _isShowButtonClear.value = false;
              },
              icon: const Icon(
                Icons.clear,
              ),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TextFormField(
        maxLines: widget.inputTextFormModel.maxLines,
        validator: widget.inputTextFormModel.validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: (v) {
          if (!_isShowButtonClear.value || v.isEmpty) {
            _isShowButtonClear.value = v.isNotEmpty;
          }
          widget.inputTextFormModel.onChanged?.call(v);
        },
        textInputAction: widget.inputTextFormModel.iconNextTextInputAction,
        style: TextStyle(
            fontSize:
                widget.inputTextFormModel.textSize ?? AppDimens.sizeTextSmall,
            color:
                widget.inputTextFormModel.textColor ?? AppColors.textColor()),
        controller: widget.inputTextFormModel.controller,
        obscureText: _showPassword.value,
        onTap: widget.inputTextFormModel.onTap,
        enabled: widget.inputTextFormModel.enable,
        autofocus: widget.inputTextFormModel.autoFocus,
        focusNode: widget.inputTextFormModel.currentNode,
        keyboardType: widget.inputTextFormModel.textInputType,
        readOnly: widget.inputTextFormModel.isReadOnly,
        maxLength: widget.inputTextFormModel.maxLengthInputForm,
        textAlign: widget.inputTextFormModel.textAlign ?? TextAlign.left,
        onFieldSubmitted: (v) {
          if (widget.inputTextFormModel.iconNextTextInputAction.toString() ==
              TextInputAction.next.toString()) {
            FocusScope.of(context)
                .requestFocus(widget.inputTextFormModel.nextNode);

            widget.inputTextFormModel.onNext?.call(v);
          } else {
            widget.inputTextFormModel.submitFunc?.call(v);
          }
        },
        decoration: createInputDecoration(),
        onEditingComplete: widget.inputTextFormModel.onEditingComplete,
      ),
    );
  }

  InputDecoration createInputDecoration() {
    return InputDecoration(
      counterText: widget.inputTextFormModel.isShowCounterText ? null : '',
      filled: true,
      isDense: widget.inputTextFormModel.isDense,
      fillColor: widget.inputTextFormModel.fillColor ?? AppColors.inputText(),
      hintStyle: TextStyle(
        fontSize: widget.inputTextFormModel.hintTextSize ??
            AppDimens.sizeTextMediumTb,
        color: widget.inputTextFormModel.hintTextColor ??
            AppColors.hintTextColor(),
      ),
      hintText: widget.inputTextFormModel.hintText,
      labelText: widget.inputTextFormModel.labelText,
      labelStyle:
          widget.inputTextFormModel.labelStyle ?? Get.textTheme.bodyMedium,
      errorStyle: TextStyle(
        color:
            widget.inputTextFormModel.errorTextColor ?? AppColors.errorText(),
      ),
      prefixIcon: widget.inputTextFormModel.iconLeading != null
          ? Icon(
              widget.inputTextFormModel.iconLeading,
              color: widget.inputTextFormModel.prefixIconColor ??
                  AppColors.hintTextColor(),
              size: 20,
            )
          : null,
      prefixStyle:
          const TextStyle(color: Colors.red, backgroundColor: Colors.white),
      border: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(widget.inputTextFormModel.borderRadius),
      ),
      focusedBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(widget.inputTextFormModel.borderRadius),
          borderSide:
              BorderSide(color: widget.inputTextFormModel.colorFocusedBorder)),
      enabledBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(widget.inputTextFormModel.borderRadius),
          borderSide: BorderSide(
              color: widget.inputTextFormModel.colorBorder ??
                  AppColors.colorBlack26)),
      contentPadding: widget.inputTextFormModel.contentPadding ??
          const EdgeInsets.all(AppDimens.paddingSmall),
      suffixIcon: widget.inputTextFormModel.isSearch
          ? _suffixIconSearch()
          : _suffixIcon(),
      suffixIconConstraints: const BoxConstraints(maxHeight: 100),
      floatingLabelBehavior: widget.inputTextFormModel.floatingLabelBehavior,
      floatingLabelStyle: widget.inputTextFormModel.floatingLabelStyle,
    );
  }
}
