import 'package:qhcare/src/features/auth/auth_page.dart';
import 'package:qhcare/src/features/dashboard/dashboard_page.dart';
import 'package:qhcare/src/features/onboarding/onboarding_page.dart';
import 'package:qhcare/src/src_barrel.dart';
import 'package:qhcare/src/utils/constants/routes/middleware/auth_middleware.dart';
import 'package:get/get.dart';

class AppPages {
  static List<GetPage> getPages = [
    GetPage(
      name: AppRoutes.home,
      page: () => OnboardingScreen(),
      middlewares: [AuthMiddleWare()],
    ),
    GetPage(name: AppRoutes.auth, page: () => AuthScreen()),
    GetPage(name: AppRoutes.dashboard, page: () => DashboardScreen()),
  ];
}
