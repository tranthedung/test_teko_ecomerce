import 'package:ecomerce/base_utils/views_base/base_widget.dart';
import 'package:ecomerce/features/home/controllers/home_ctrl.dart';
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
      body: _buildBody(controller),
    );
  }
}
