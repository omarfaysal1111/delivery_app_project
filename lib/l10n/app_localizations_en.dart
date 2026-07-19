// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Driver App';

  @override
  String get changeAppLanguageTitle => 'Change App Language';

  @override
  String get languageArabicChip => 'عربي';

  @override
  String get languageEnglishChip => 'English';

  @override
  String get loginTitle => 'Sign in!';

  @override
  String get loginSubtitle =>
      'Enter your mobile number to complete the registration process';

  @override
  String get loginPhoneLabel => 'Mobile number';

  @override
  String get loginPhoneHint => 'Mobile number';

  @override
  String get loginSubmit => 'Confirm';

  @override
  String get loginNoAccount => 'New driver? ';

  @override
  String get loginCreateAccount => 'Create account';

  @override
  String get biometricSoon => 'Biometric sign-in coming soon';

  @override
  String get otpTitle => 'Verification code';

  @override
  String get otpSubtitle =>
      'Enter the code sent to you to confirm your mobile number and continue.';

  @override
  String get otpVerify => 'Verify';

  @override
  String otpTimerSeconds(int seconds) {
    return '${seconds}s';
  }

  @override
  String get otpResend => 'Resend code?';

  @override
  String get otpResentSnackbar => 'Code sent again';

  @override
  String get registerWelcomeTitle => 'Welcome!';

  @override
  String get registerWelcomeSubtitle =>
      'Please enter the required registration details';

  @override
  String get registerProfilePhotoLabel => 'Profile photo';

  @override
  String get registerUsernameLabel => 'Username';

  @override
  String get registerUsernameHint => 'Username';

  @override
  String get registerPhoneLabel => 'Mobile number';

  @override
  String get registerPhoneHint => 'Mobile number';

  @override
  String get registerEmailLabel => 'Email';

  @override
  String get registerEmailHint => 'Email';

  @override
  String get registerNationalIdLabel => 'National ID';

  @override
  String get registerNationalIdHint => 'National ID';

  @override
  String get registerVehicleTypeLabel => 'Vehicle type';

  @override
  String get registerVehicleTypeHint => 'Type';

  @override
  String get registerVehicleNumberLabel => 'Vehicle number';

  @override
  String get registerVehicleNumberHint => 'Vehicle number';

  @override
  String get vehicleTypeMotorcycle => 'Motorcycle';

  @override
  String get vehicleTypeCar => 'Car';

  @override
  String get vehicleTypeBicycle => 'Bicycle';

  @override
  String get registerUploadDrivingLicense => 'Attach driving license photo';

  @override
  String get registerUploadVehicleLicense => 'Attach vehicle license photo';

  @override
  String get registerUploadNationalId => 'Attach national ID photo';

  @override
  String get uploadTapToUpload => 'Tap to upload';

  @override
  String get uploadSuccessAdded => 'File added successfully';

  @override
  String get registerSubmit => 'Confirm';

  @override
  String get registerHasAccount => 'Already have an account? ';

  @override
  String get registerSignIn => 'Sign in';

  @override
  String get registrationPendingMessage =>
      'Your details were submitted and are awaiting admin approval.';

  @override
  String get validationUsernameRequired => 'Username is required';

  @override
  String get validationUsernameMin3 => 'Username must be at least 3 characters';

  @override
  String get validationPhoneRequired => 'Mobile number is required';

  @override
  String get validationPhoneEgyptian =>
      'Please enter a valid Egyptian mobile number';

  @override
  String get validationEmailRequired => 'Email is required';

  @override
  String get validationEmailInvalid => 'Please enter a valid email address';

  @override
  String get validationNationalIdRequired => 'National ID is required';

  @override
  String get validationNationalIdInvalid => 'National ID must be 14 digits';

  @override
  String get validationVehicleTypeRequired => 'Vehicle type is required';

  @override
  String get validationVehicleNumberRequired => 'Vehicle number is required';

  @override
  String get validationDocumentRequired => 'Please upload this document';

  @override
  String get validationProfilePhotoRequired => 'Profile photo is required';

  @override
  String get validationOtpRequired => 'Verification code is required';

  @override
  String get validationOtpSixDigits => 'Please enter 6 digits';

  @override
  String get otpVerifyButton => 'Verify';

  @override
  String get otpResendCode => 'Resend Code?';

  @override
  String get otpSeconds => 'seconds';

  @override
  String get pendingSuccessTitle => 'Request submitted successfully';

  @override
  String get pendingSuccessSubtitle =>
      'Your request is being reviewed by the administration and will be answered as soon as possible';

  @override
  String get registerTitle => 'Register your data';

  @override
  String get registerSubtitle =>
      'Please complete the following data to complete the registration process';

  @override
  String get registerDriverLicense => 'Driver\'s license photo';

  @override
  String get registerNationalId => 'National ID / Iqama photo';

  @override
  String get registerCarRegistration => 'Car registration photo';

  @override
  String get registerSubmitButton => 'Submit Data';

  @override
  String get registerUploadPhoto => 'Upload photo here';

  @override
  String get drawerHome => 'Home';

  @override
  String get drawerGeneralSettings => 'General Settings';

  @override
  String get drawerNotifications => 'Notifications';

  @override
  String get drawerReviews => 'Reviews';

  @override
  String get drawerWallet => 'Wallet';

  @override
  String get drawerSupport => 'Technical Support';

  @override
  String get drawerTerms => 'Terms & Conditions';

  @override
  String get drawerLogout => 'Logout';

  @override
  String get noReviewsYet => 'No reviews yet.';

  @override
  String get noNotificationsYet => 'No notifications yet.';

  @override
  String get drawerGuestName => 'User';

  @override
  String get logoutConfirmTitle => 'Logout';

  @override
  String get logoutConfirmMessage => 'Are you sure you want to logout?';

  @override
  String get confirm => 'Confirm';

  @override
  String get cancel => 'Cancel';

  @override
  String get deleteAccountSuccess => 'Account deleted successfully';

  @override
  String get settingsUpdatedSuccess => 'Settings updated successfully';

  @override
  String get generalSettingsTitle => 'General Settings';

  @override
  String get changeAppLanguage => 'Change Language';

  @override
  String get arabicLanguage => 'Arabic';

  @override
  String get englishLanguage => 'English';

  @override
  String get notificationsControl => 'Notifications';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get deleteAccount => 'Delete Account';

  @override
  String get deleteAccountConfirmationTitle => 'Delete Account';

  @override
  String get deleteAccountConfirmationMessage =>
      'Are you sure you want to delete your account? This action cannot be undone.';

  @override
  String get supportChatTitle => 'Technical Support';

  @override
  String get supportToday => 'Today';

  @override
  String get supportGoodEvening => 'Good evening';

  @override
  String get supportHowCanWeHelp => 'How can we help you?';

  @override
  String get supportSampleUserIssue => 'I have an issue with the application.';

  @override
  String get supportInputHint => 'Write your message here...';

  @override
  String get termsTitle => 'Terms & Conditions';

  @override
  String get termsBody => 'These are the terms and conditions...';

  @override
  String get changePhoneNumber => 'Change Phone Number';

  @override
  String get manageOrderReception => 'Manage Order Reception';

  @override
  String get currentPhoneLabel => 'Current Phone Number';

  @override
  String get newPhoneLabel => 'New Phone Number';

  @override
  String get verifyPhoneButton => 'Verify';

  @override
  String get enterCurrentPhone => 'Enter your current phone number';

  @override
  String get enterNewPhone => 'Enter your new phone number';

  @override
  String get invalidPhone => 'Invalid phone number';

  @override
  String get phoneChangedSuccess => 'Phone number updated successfully';
}
