import 'package:ecomerce/assets/strings.dart';
import 'package:ecomerce/core/theme/colors.dart';
import 'package:ecomerce/routes/pages.dart';
import 'package:ecomerce/routes/routes.dart';
import 'package:ecomerce/shares/keyboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runApp(const Application());
}

class Application extends StatefulWidget {
  const Application({Key? key}) : super(key: key);

  @override
  State<Application> createState() => _Application();
}

class _Application extends State<Application> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        systemNavigationBarColor: AppColors.color,
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: KeyBoard.hide,
      child: GetMaterialApp(
        // locale: const Locale('vi', 'VN'),
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.routeHome,
        getPages: RoutePage.route,
        builder: (context, child) => ScrollConfiguration(
          behavior: MyBehavior(),
          child: MediaQuery(
              data:
                  MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
              child: child ?? Container()),
        ),
        // localizationsDelegates: const [
        //   GlobalCupertinoLocalizations.delegate,
        //   GlobalMaterialLocalizations.delegate,
        //   GlobalWidgetsLocalizations.delegate,
        //   DefaultCupertinoLocalizations.delegate
        // ],
        supportedLocales: const [
          Locale('vi', ''),
          Locale('en', ''),
        ],
        title: AppStr.appName,
        //   theme: getThemeByAppTheme(false)
        //       .copyWith(unselectedWidgetColor: AppColors.colorMain),
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }
}
