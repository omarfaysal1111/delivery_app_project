import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Driver App'**
  String get appTitle;

  /// No description provided for @changeAppLanguageTitle.
  ///
  /// In en, this message translates to:
  /// **'Change App Language'**
  String get changeAppLanguageTitle;

  /// No description provided for @languageArabicChip.
  ///
  /// In en, this message translates to:
  /// **'عربي'**
  String get languageArabicChip;

  /// No description provided for @languageEnglishChip.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglishChip;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in!'**
  String get loginTitle;

  /// No description provided for @loginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome back — sign in to continue.'**
  String get loginSubtitle;

  /// No description provided for @loginPhoneLabel.
  ///
  /// In en, this message translates to:
  /// **'Mobile number'**
  String get loginPhoneLabel;

  /// No description provided for @loginPhoneHint.
  ///
  /// In en, this message translates to:
  /// **'Mobile number'**
  String get loginPhoneHint;

  /// No description provided for @loginSubmit.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get loginSubmit;

  /// No description provided for @loginNoAccount.
  ///
  /// In en, this message translates to:
  /// **'New driver? '**
  String get loginNoAccount;

  /// No description provided for @loginCreateAccount.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get loginCreateAccount;

  /// No description provided for @biometricSoon.
  ///
  /// In en, this message translates to:
  /// **'Biometric sign-in coming soon'**
  String get biometricSoon;

  /// No description provided for @otpTitle.
  ///
  /// In en, this message translates to:
  /// **'Verification code'**
  String get otpTitle;

  /// No description provided for @otpSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter the code sent to you to confirm your mobile number and continue.'**
  String get otpSubtitle;

  /// No description provided for @otpVerify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get otpVerify;

  /// No description provided for @otpTimerSeconds.
  ///
  /// In en, this message translates to:
  /// **'{seconds}s'**
  String otpTimerSeconds(int seconds);

  /// No description provided for @otpResend.
  ///
  /// In en, this message translates to:
  /// **'Resend code?'**
  String get otpResend;

  /// No description provided for @otpResentSnackbar.
  ///
  /// In en, this message translates to:
  /// **'Code sent again'**
  String get otpResentSnackbar;

  /// No description provided for @registerWelcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome!'**
  String get registerWelcomeTitle;

  /// No description provided for @registerWelcomeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Join us today and enjoy a faster delivery experience.'**
  String get registerWelcomeSubtitle;

  /// No description provided for @registerProfilePhotoLabel.
  ///
  /// In en, this message translates to:
  /// **'Profile photo'**
  String get registerProfilePhotoLabel;

  /// No description provided for @registerUsernameLabel.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get registerUsernameLabel;

  /// No description provided for @registerUsernameHint.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get registerUsernameHint;

  /// No description provided for @registerPhoneLabel.
  ///
  /// In en, this message translates to:
  /// **'Mobile number'**
  String get registerPhoneLabel;

  /// No description provided for @registerPhoneHint.
  ///
  /// In en, this message translates to:
  /// **'Mobile number'**
  String get registerPhoneHint;

  /// No description provided for @registerEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get registerEmailLabel;

  /// No description provided for @registerEmailHint.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get registerEmailHint;

  /// No description provided for @registerNationalIdLabel.
  ///
  /// In en, this message translates to:
  /// **'National ID'**
  String get registerNationalIdLabel;

  /// No description provided for @registerNationalIdHint.
  ///
  /// In en, this message translates to:
  /// **'National ID'**
  String get registerNationalIdHint;

  /// No description provided for @registerVehicleTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Vehicle type'**
  String get registerVehicleTypeLabel;

  /// No description provided for @registerVehicleTypeHint.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get registerVehicleTypeHint;

  /// No description provided for @vehicleTypeMotorcycle.
  ///
  /// In en, this message translates to:
  /// **'Motorcycle'**
  String get vehicleTypeMotorcycle;

  /// No description provided for @vehicleTypeCar.
  ///
  /// In en, this message translates to:
  /// **'Car'**
  String get vehicleTypeCar;

  /// No description provided for @vehicleTypeBicycle.
  ///
  /// In en, this message translates to:
  /// **'Bicycle'**
  String get vehicleTypeBicycle;

  /// No description provided for @registerUploadDrivingLicense.
  ///
  /// In en, this message translates to:
  /// **'Attach driving license photo'**
  String get registerUploadDrivingLicense;

  /// No description provided for @registerUploadVehicleLicense.
  ///
  /// In en, this message translates to:
  /// **'Attach vehicle license photo'**
  String get registerUploadVehicleLicense;

  /// No description provided for @registerUploadNationalId.
  ///
  /// In en, this message translates to:
  /// **'Attach national ID photo'**
  String get registerUploadNationalId;

  /// No description provided for @uploadTapToUpload.
  ///
  /// In en, this message translates to:
  /// **'Tap to upload'**
  String get uploadTapToUpload;

  /// No description provided for @uploadSuccessAdded.
  ///
  /// In en, this message translates to:
  /// **'File added successfully'**
  String get uploadSuccessAdded;

  /// No description provided for @registerSubmit.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get registerSubmit;

  /// No description provided for @registerHasAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? '**
  String get registerHasAccount;

  /// No description provided for @registerSignIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get registerSignIn;

  /// No description provided for @registrationPendingMessage.
  ///
  /// In en, this message translates to:
  /// **'Your details were submitted and are awaiting admin approval.'**
  String get registrationPendingMessage;

  /// No description provided for @validationUsernameRequired.
  ///
  /// In en, this message translates to:
  /// **'Username is required'**
  String get validationUsernameRequired;

  /// No description provided for @validationUsernameMin3.
  ///
  /// In en, this message translates to:
  /// **'Username must be at least 3 characters'**
  String get validationUsernameMin3;

  /// No description provided for @validationPhoneRequired.
  ///
  /// In en, this message translates to:
  /// **'Mobile number is required'**
  String get validationPhoneRequired;

  /// No description provided for @validationPhoneEgyptian.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid Egyptian mobile number'**
  String get validationPhoneEgyptian;

  /// No description provided for @validationEmailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get validationEmailRequired;

  /// No description provided for @validationEmailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address'**
  String get validationEmailInvalid;

  /// No description provided for @validationNationalIdRequired.
  ///
  /// In en, this message translates to:
  /// **'National ID is required'**
  String get validationNationalIdRequired;

  /// No description provided for @validationNationalIdInvalid.
  ///
  /// In en, this message translates to:
  /// **'National ID must be 14 digits'**
  String get validationNationalIdInvalid;

  /// No description provided for @validationVehicleTypeRequired.
  ///
  /// In en, this message translates to:
  /// **'Vehicle type is required'**
  String get validationVehicleTypeRequired;

  /// No description provided for @validationDocumentRequired.
  ///
  /// In en, this message translates to:
  /// **'Please upload this document'**
  String get validationDocumentRequired;

  /// No description provided for @validationProfilePhotoRequired.
  ///
  /// In en, this message translates to:
  /// **'Profile photo is required'**
  String get validationProfilePhotoRequired;

  /// No description provided for @validationOtpRequired.
  ///
  /// In en, this message translates to:
  /// **'Verification code is required'**
  String get validationOtpRequired;

  /// No description provided for @validationOtpSixDigits.
  ///
  /// In en, this message translates to:
  /// **'Please enter 6 digits'**
  String get validationOtpSixDigits;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
