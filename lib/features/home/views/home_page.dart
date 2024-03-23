import 'package:ecomerce/base_utils/views_base/base_widget.dart';
import 'package:ecomerce/core/values/colors.dart';
import 'package:ecomerce/core/values/dimens.dart';
import 'package:ecomerce/features/home/controllers/home_ctrl.dart';
import 'package:ecomerce/shares/util_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'home_widget.dart';

class HomePage extends BaseGetWidget<HomeCtrl> {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomeCtrl get controller => Get.put(HomeCtrl());
  @override
  Widget buildWidgets(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      backgroundColor: AppColors.colorBasicGrey2,
      body: _buildBody(controller),
    );
  }
}
