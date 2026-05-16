/// Route paths. Auth/onboarding routes are implemented; driver flows are stubs.
class RouteNames {
  RouteNames._();

  // ── Auth & onboarding (implemented) ─────────────────────────────────────────
  static const splash = '/';
  static const login = '/login';
  static const register = '/register';
  static const otp = '/otp';
  static const documentUpload = '/document-upload';
  static const registrationPending = '/registration-pending';
  static const onboardingTraining = '/onboarding-training';

  // ── Driver app (not implemented — reserved) ─────────────────────────────────
  static const driverHome = '/home';
  static const shift = '/shift';
  static const newOrderRequest = '/order/new';
  static const activeOrderPickup = '/order/pickup';
  static const activeOrderDelivery = '/order/delivery';
  static const deliveryConfirmation = '/order/confirm';
  static const orderIssue = '/order/issue';
  static const earnings = '/earnings';
  static const earningsHistory = '/earnings/history';
  static const incentives = '/earnings/incentives';
  static const performance = '/earnings/performance';
  static const inAppNavigation = '/navigation';
  static const zoneMap = '/zone-map';
  static const profile = '/profile';
  static const documents = '/profile/documents';
  static const payoutDetails = '/profile/payout';
  static const notifications = '/profile/notifications';
  static const support = '/profile/support';
  static const settings = '/profile/settings';
}
