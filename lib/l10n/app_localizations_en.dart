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
  String get loginSubtitle => 'Welcome back — sign in to continue.';

  @override
  String get loginPhoneLabel => 'Mobile number';

  @override
  String get loginPhoneHint => 'Mobile number';

  @override
  String get loginSubmit => 'Sign in';

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
      'Join us today and enjoy a faster delivery experience.';

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
  String get validationDocumentRequired => 'Please upload this document';

  @override
  String get validationProfilePhotoRequired => 'Profile photo is required';

  @override
  String get validationOtpRequired => 'Verification code is required';

  @override
  String get validationOtpSixDigits => 'Please enter 6 digits';
}
