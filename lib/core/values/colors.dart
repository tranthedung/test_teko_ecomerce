import 'package:flutter/material.dart';

class AppColors {
  // Theme mặc định
  static const Color colorLightAccent = Color(0xFFf5f5f5);

  static const Color white = Colors.white;
  static const Color colorTransparent = Color(0x00000000);

  static const Color colorBasicGrey = Color(0xFF6E7A8E);
  static const Color colorBasicGrey2 = Color(0xFF9BA3B1);
  static const Color colorBasicGrey3 = Color(0xFFE9EBEE);
  static const Color colorBasicBlack = Color(0xFF2A2B2A);

  static const Color colorsOrange = Color(0xFFFF6600);
  static const Color colorLoading = Color(0xFF58a0ff);
  static const Color colorButton = Color(0xFF25273f);
  static const Color colorGrey = Colors.grey;
  static const Color colorTitleAppbar = Color(0xFF2A2B2A);
  static const Color colorTextDefault = Color(0xFF111111);
  static const Color colorBackgroundLight = Color(0xFFf7f7f7);
  static const Color lightPrimaryColor = Color(0xFF0074bd);
  static const Color colorAttention = Color(0xccEF4444);
  static const Color colorRedDark = Color(0xFFD32F2F);
  static const Color colorDarkPrimary = Color(0xFF3e4161);
  static const Color colorErrorText = Color(0xFFFFCB12);
  static const Color colorBlack26 = Color.fromARGB(66, 0, 0, 0);
  static const Color colorWhite = Color(0xFFFFFFFF);
  static const Color dsPrimaryBlueBlue = Color(0xFF0074BD);

  static bool _isDarkMode() => false;

  static Color bottomSheet() => _isDarkMode() ? colorButton : Colors.white;
  static Color textColor() => _isDarkMode() ? Colors.white : Colors.black;
  static Color inputText() =>
      _isDarkMode() ? colorDarkPrimary : colorLightAccent;
  static Color hintTextColor() =>
      _isDarkMode() ? Colors.white54 : Colors.black54;
  static Color errorText() => _isDarkMode() ? colorErrorText : Colors.redAccent;
}
