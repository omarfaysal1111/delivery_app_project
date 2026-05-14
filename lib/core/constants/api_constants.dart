class ApiConstants {
  static const String baseUrl = 'https://api.yourdeliveryapp.com/v1';
  static const Duration timeout = Duration(seconds: 30);

  // Auth
  static const String sendOtp       = '/driver/otp/send';
  static const String verifyOtp     = '/driver/otp/verify';
  static const String register      = '/driver/register';
  static const String logout        = '/driver/logout';

  // Documents
  static const String documents     = '/driver/documents';

  // Home
  static const String driverStatus  = '/driver/status';
  static const String todayStats    = '/driver/stats/today';
  static const String shifts        = '/driver/shifts';

  // Orders
  static const String activeOrder   = '/driver/orders/active';
  static const String acceptOrder   = '/driver/orders/{id}/accept';
  static const String declineOrder  = '/driver/orders/{id}/decline';
  static const String arrivedOrder  = '/driver/orders/{id}/arrived';
  static const String confirmOrder  = '/driver/orders/{id}/confirm';
  static const String reportIssue   = '/driver/orders/{id}/issue';
  static const String driverLocation = '/driver/location';

  // Earnings
  static const String earnings      = '/driver/earnings';
  static const String earningsHistory = '/driver/earnings/history';
  static const String incentives    = '/driver/incentives';
  static const String performance   = '/driver/performance';
  static const String withdrawal    = '/driver/earnings/withdraw';

  // Map
  static const String surgeZones    = '/driver/zones';

  // Profile
  static const String profile       = '/driver/profile';
  static const String payout        = '/driver/payout';
}
