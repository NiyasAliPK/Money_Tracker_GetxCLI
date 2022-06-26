import 'package:get/get.dart';

import 'package:money_tracker_get_cli/app/modules/add/bindings/add_binding.dart';
import 'package:money_tracker_get_cli/app/modules/add/views/add_view.dart';
import 'package:money_tracker_get_cli/app/modules/billimage/bindings/billimage_binding.dart';
import 'package:money_tracker_get_cli/app/modules/billimage/views/billimage_view.dart';
import 'package:money_tracker_get_cli/app/modules/category/bindings/category_binding.dart';
import 'package:money_tracker_get_cli/app/modules/category/views/category_view.dart';
import 'package:money_tracker_get_cli/app/modules/details/bindings/details_binding.dart';
import 'package:money_tracker_get_cli/app/modules/details/views/details_view.dart';
import 'package:money_tracker_get_cli/app/modules/edit/bindings/edit_binding.dart';
import 'package:money_tracker_get_cli/app/modules/edit/views/edit_view.dart';
import 'package:money_tracker_get_cli/app/modules/home/bindings/home_binding.dart';
import 'package:money_tracker_get_cli/app/modules/home/views/home_view.dart';
import 'package:money_tracker_get_cli/app/modules/navigation/bindings/navigation_binding.dart';
import 'package:money_tracker_get_cli/app/modules/navigation/views/navigation_view.dart';
import 'package:money_tracker_get_cli/app/modules/settings/bindings/settings_binding.dart';
import 'package:money_tracker_get_cli/app/modules/settings/views/settings_view.dart';
import 'package:money_tracker_get_cli/app/modules/splash/bindings/splash_binding.dart';
import 'package:money_tracker_get_cli/app/modules/splash/views/splash_view.dart';
import 'package:money_tracker_get_cli/app/modules/stats/bindings/stats_binding.dart';
import 'package:money_tracker_get_cli/app/modules/stats/views/stats_view.dart';
import 'package:money_tracker_get_cli/app/modules/viewall/bindings/viewall_binding.dart';
import 'package:money_tracker_get_cli/app/modules/viewall/views/viewall_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.NAVIGATION,
      page: () => NavigationView(),
      binding: NavigationBinding(),
    ),
    GetPage(
      name: _Paths.STATS,
      page: () => StatsView(),
      binding: StatsBinding(),
    ),
    GetPage(
      name: _Paths.CATEGORY,
      page: () => CategoryView(),
      binding: CategoryBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.ADD,
      page: () => AddView(),
      binding: AddBinding(),
    ),
    GetPage(
      name: _Paths.VIEWALL,
      page: () => ViewallView(),
      binding: ViewallBinding(),
    ),
    GetPage(
      name: _Paths.DETAILS,
      page: () => DetailsView(null),
      binding: DetailsBinding(),
    ),
    GetPage(
      name: _Paths.EDIT,
      page: () => EditView(),
      binding: EditBinding(),
    ),
    GetPage(
      name: _Paths.BILLIMAGE,
      page: () => BillimageView(),
      binding: BillimageBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
  ];
}
