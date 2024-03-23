import 'package:ecomerce/features/home/views/home_page.dart';
import 'package:ecomerce/routes/routes.dart';
import 'package:get/get.dart';

class RoutePage {
  static var route = [
    GetPage(
      name: AppRoutes.routeHome,
      page: () => const HomePage(),
    ),
  ];
}
