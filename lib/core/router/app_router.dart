import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/pages/document_upload_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/otp_verification_page.dart';
import '../../features/auth/presentation/pages/register_driver_page.dart';
import '../../features/auth/presentation/pages/registration_pending_page.dart';
import '../../features/splash/presentation/pages/splash_screen.dart';
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
        path: RouteNames.login,
        builder: (c, s) => const LoginPage(),
      ),
      GoRoute(
        path: RouteNames.register,
        builder: (c, s) => const RegisterDriverPage(),
      ),
      GoRoute(
        path: RouteNames.otp,
        builder: (c, s) => OtpVerificationPage(
          phone: s.extra as String?,
        ),
      ),
      GoRoute(
        path: RouteNames.documentUpload,
        builder: (c, s) => const DocumentUploadPage(),
      ),
      GoRoute(
        path: RouteNames.registrationPending,
        builder: (c, s) => const RegistrationPendingPage(),
      ),
      GoRoute(
        path: RouteNames.onboardingTraining,
        builder: (c, s) => const PlaceholderScreen(
          routeLabel: RouteNames.onboardingTraining,
        ),
      ),
      _stub(RouteNames.driverHome),
      _stub(RouteNames.shift),
      _stub(RouteNames.newOrderRequest),
      _stub(RouteNames.activeOrderPickup),
      _stub(RouteNames.activeOrderDelivery),
      _stub(RouteNames.deliveryConfirmation),
      _stub(RouteNames.orderIssue),
      _stub(RouteNames.earnings),
      _stub(RouteNames.earningsHistory),
      _stub(RouteNames.incentives),
      _stub(RouteNames.performance),
      _stub(RouteNames.inAppNavigation),
      _stub(RouteNames.zoneMap),
      _stub(RouteNames.profile),
      _stub(RouteNames.documents),
      _stub(RouteNames.payoutDetails),
      _stub(RouteNames.notifications),
      _stub(RouteNames.support),
      _stub(RouteNames.settings),
    ],
  );

  static GoRoute _stub(String path) => GoRoute(
        path: path,
        builder: (c, s) => PlaceholderScreen(routeLabel: path),
      );
}
