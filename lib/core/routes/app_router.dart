import 'package:flutter/material.dart';

class AppRouter {
  static const String splash              = '/';
  static const String login              = '/login';
  static const String register           = '/register';
  static const String documentUpload     = '/document-upload';
  static const String otpVerification    = '/otp';
  static const String onboardingTraining = '/onboarding-training';
  static const String driverHome         = '/home';
  static const String shift              = '/shift';
  static const String newOrderRequest    = '/order/new';
  static const String activeOrderPickup  = '/order/pickup';
  static const String activeOrderDelivery = '/order/delivery';
  static const String deliveryConfirmation = '/order/confirm';
  static const String orderIssue         = '/order/issue';
  static const String earnings           = '/earnings';
  static const String earningsHistory    = '/earnings/history';
  static const String incentives         = '/earnings/incentives';
  static const String performance        = '/earnings/performance';
  static const String inAppNavigation    = '/navigation';
  static const String zoneMap            = '/zone-map';
  static const String profile            = '/profile';
  static const String documents          = '/profile/documents';
  static const String payoutDetails      = '/profile/payout';
  static const String notifications      = '/profile/notifications';
  static const String support            = '/profile/support';
  static const String settings           = '/profile/settings';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      settings: settings,
      builder: (_) => const Scaffold(
        body: Center(child: Text('Route not wired yet')),
      ),
    );
  }
}
