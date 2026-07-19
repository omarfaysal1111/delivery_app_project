import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/otp_page.dart';
import '../../features/auth/presentation/pages/register_driver_page.dart';
import '../../features/auth/presentation/pages/registration_pending_page.dart';
import '../../features/auth/presentation/pages/language_page.dart';
import '../../features/auth/presentation/pages/splash_screen.dart';
import 'placeholder_screen.dart';
import 'route_names.dart';

class AppRouter {
  AppRouter._();

  static final router = GoRouter(
    initialLocation: RouteNames.splash,
    routes: [
      GoRoute(
        path: RouteNames.splash,
        builder: (c, s) => const SplashScreen(),
      ),
      GoRoute(
        path: RouteNames.language,
        builder: (c, s) => const LanguagePage(),
      ),
      GoRoute(
        path: RouteNames.login,
        builder: (c, s) => const LoginPage(),
      ),
      GoRoute(
        path: RouteNames.otp,
        builder: (c, s) => const OtpPage(),
      ),
      GoRoute(
        path: RouteNames.register,
        builder: (c, s) => const RegisterDriverPage(),
      ),
      GoRoute(
        path: RouteNames.pending,
        builder: (c, s) => const RegistrationPendingPage(),
      ),
      _stub(RouteNames.driverHome),
    ],
  );

  static GoRoute _stub(String path) => GoRoute(
        path: path,
        builder: (c, s) => PlaceholderScreen(routeLabel: path),
      );
}
