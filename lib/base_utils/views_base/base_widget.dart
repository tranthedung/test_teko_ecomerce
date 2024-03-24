import 'package:ecomerce/base_utils/controller_base/base_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

abstract class BaseGetWidget<T extends BaseGetxController> extends GetView<T> {
  const BaseGetWidget({Key? key}) : super(key: key);

  Widget buildWidgets(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return buildWidgets(context);
  }
}
