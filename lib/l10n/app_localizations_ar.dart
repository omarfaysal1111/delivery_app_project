// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'تطبيق السائق';

  @override
  String get changeAppLanguageTitle => 'تغيير لغة التطبيق';

  @override
  String get languageArabicChip => 'عربي';

  @override
  String get languageEnglishChip => 'English';

  @override
  String get loginTitle => 'تسجيل دخول !';

  @override
  String get loginSubtitle => 'أدخل رقم الجوال الخاص بك لإتمام عملية التسجيل';

  @override
  String get loginPhoneLabel => 'رقم الجوال';

  @override
  String get loginPhoneHint => 'رقم الجوال';

  @override
  String get loginSubmit => 'تأكيد';

  @override
  String get loginNoAccount => 'سائق جديد؟ ';

  @override
  String get loginCreateAccount => 'إنشاء حساب';

  @override
  String get biometricSoon => 'تسجيل الدخول بالبصمة قريباً';

  @override
  String get otpTitle => 'كود التحقق';

  @override
  String get otpSubtitle =>
      'أدخل الكود المرسل إليك لتأكيد رقم الجوال والمتابعة.';

  @override
  String get otpVerify => 'تحقق';

  @override
  String otpTimerSeconds(int seconds) {
    return '$seconds ثانية';
  }

  @override
  String get otpResend => 'إعادة إرسال الكود ؟';

  @override
  String get otpResentSnackbar => 'تم إرسال الكود مرة أخرى';

  @override
  String get registerWelcomeTitle => 'مرحباً بك !';

  @override
  String get registerWelcomeSubtitle => 'قم بإدخال بيانات التسجيل المطلوبة';

  @override
  String get registerProfilePhotoLabel => 'الصورة الشخصية';

  @override
  String get registerUsernameLabel => 'اسم المستخدم';

  @override
  String get registerUsernameHint => 'اسم المستخدم';

  @override
  String get registerPhoneLabel => 'رقم الجوال';

  @override
  String get registerPhoneHint => 'رقم الجوال';

  @override
  String get registerEmailLabel => 'البريد الالكتروني';

  @override
  String get registerEmailHint => 'البريد الالكتروني';

  @override
  String get registerNationalIdLabel => 'الرقم القومي';

  @override
  String get registerNationalIdHint => 'الرقم القومي';

  @override
  String get registerVehicleTypeLabel => 'نوع المركبة';

  @override
  String get registerVehicleTypeHint => 'النوع';

  @override
  String get registerVehicleNumberLabel => 'رقم المركبة';

  @override
  String get registerVehicleNumberHint => 'رقم المركبة';

  @override
  String get vehicleTypeMotorcycle => 'موتوسيكل';

  @override
  String get vehicleTypeCar => 'سيارة';

  @override
  String get vehicleTypeBicycle => 'دراجة';

  @override
  String get registerUploadDrivingLicense => 'إرفق صوره رخصه القيادة';

  @override
  String get registerUploadVehicleLicense => 'إرفق صوره رخصه المركبة';

  @override
  String get registerUploadNationalId => 'ارفق صوره الهويه الوطنيه';

  @override
  String get uploadTapToUpload => 'اضغط للرفع';

  @override
  String get uploadSuccessAdded => 'تم إضافة الملف بنجاح';

  @override
  String get registerSubmit => 'تأكيد';

  @override
  String get registerHasAccount => 'هل لديك حساب من قبل؟ ';

  @override
  String get registerSignIn => 'تسجيل دخول';

  @override
  String get registrationPendingMessage =>
      'تم إرسال بياناتك وبإنتظار موافقة الادارة';

  @override
  String get validationUsernameRequired => 'اسم المستخدم مطلوب';

  @override
  String get validationUsernameMin3 => 'اسم المستخدم يجب ألا يقل عن ٣ أحرف';

  @override
  String get validationPhoneRequired => 'رقم الجوال مطلوب';

  @override
  String get validationPhoneEgyptian => 'يرجى إدخال رقم جوال مصري صحيح';

  @override
  String get validationEmailRequired => 'البريد الالكتروني مطلوب';

  @override
  String get validationEmailInvalid => 'يرجى إدخال بريد إلكتروني صحيح';

  @override
  String get validationNationalIdRequired => 'الرقم القومي مطلوب';

  @override
  String get validationNationalIdInvalid => 'الرقم القومي يجب أن يكون ١٤ رقماً';

  @override
  String get validationVehicleTypeRequired => 'نوع المركبة مطلوب';

  @override
  String get validationVehicleNumberRequired => 'رقم المركبة مطلوب';

  @override
  String get validationDocumentRequired => 'يرجى رفع هذا المستند';

  @override
  String get validationProfilePhotoRequired => 'الصورة الشخصية مطلوبة';

  @override
  String get validationOtpRequired => 'رمز التحقق مطلوب';

  @override
  String get validationOtpSixDigits => 'يرجى إدخال ٦ أرقام';

  @override
  String get otpVerifyButton => 'تحقق';

  @override
  String get otpResendCode => 'إعادة إرسال الكود ؟';

  @override
  String get otpSeconds => 'ثانية';

  @override
  String get pendingSuccessTitle => 'تم تقديم الطلب بنجاح';

  @override
  String get pendingSuccessSubtitle =>
      'جاري مراجعة طلبك من قبل الإدارة وسيتم الرد عليك في أقرب وقت ممكن';

  @override
  String get registerTitle => 'تسجيل بياناتك';

  @override
  String get registerSubtitle =>
      'يرجى استكمال البيانات التالية لإتمام عملية التسجيل';

  @override
  String get registerDriverLicense => 'صورة رخصة القيادة';

  @override
  String get registerNationalId => 'صورة الهوية الوطنية / الإقامة';

  @override
  String get registerCarRegistration => 'صورة استمارة السيارة';

  @override
  String get registerSubmitButton => 'إرسال البيانات';

  @override
  String get registerUploadPhoto => 'قم برفع الصورة من هنا';

  @override
  String get drawerHome => 'الرئيسية';

  @override
  String get drawerGeneralSettings => 'الإعدادات العامة';

  @override
  String get drawerNotifications => 'الإشعارات';

  @override
  String get drawerReviews => 'التقييمات';

  @override
  String get drawerWallet => 'المحفظة';

  @override
  String get drawerSupport => 'الدعم الفني';

  @override
  String get drawerTerms => 'الشروط والأحكام';

  @override
  String get drawerLogout => 'تسجيل الخروج';

  @override
  String get noReviewsYet => 'لا توجد تقييمات حتى الآن.';

  @override
  String get noNotificationsYet => 'لا توجد إشعارات حتى الآن.';

  @override
  String get drawerGuestName => 'مستخدم';

  @override
  String get logoutConfirmTitle => 'تسجيل الخروج';

  @override
  String get logoutConfirmMessage => 'هل أنت متأكد من تسجيل الخروج؟';

  @override
  String get confirm => 'تأكيد';

  @override
  String get cancel => 'إلغاء';

  @override
  String get deleteAccountSuccess => 'تم حذف الحساب بنجاح';

  @override
  String get settingsUpdatedSuccess => 'تم تحديث الإعدادات بنجاح';

  @override
  String get generalSettingsTitle => 'الإعدادات العامة';

  @override
  String get changeAppLanguage => 'تغيير لغة التطبيق';

  @override
  String get arabicLanguage => 'عربي';

  @override
  String get englishLanguage => 'English';

  @override
  String get notificationsControl => 'الإشعارات';

  @override
  String get darkMode => 'الوضع الداكن';

  @override
  String get deleteAccount => 'حذف الحساب';

  @override
  String get deleteAccountConfirmationTitle => 'حذف الحساب';

  @override
  String get deleteAccountConfirmationMessage =>
      'هل أنت متأكد من حذف الحساب؟ لا يمكن التراجع عن هذا الإجراء.';

  @override
  String get supportChatTitle => 'الدعم الفني';

  @override
  String get supportToday => 'اليوم';

  @override
  String get supportGoodEvening => 'مساء الخير';

  @override
  String get supportHowCanWeHelp => 'كيف يمكننا مساعدتك؟';

  @override
  String get supportSampleUserIssue => 'لدي مشكلة في التطبيق.';

  @override
  String get supportInputHint => 'اكتب رسالتك هنا...';

  @override
  String get termsTitle => 'الشروط والأحكام';

  @override
  String get termsBody => 'هذه هي الشروط والأحكام...';

  @override
  String get changePhoneNumber => 'تغيير رقم الجوال';

  @override
  String get manageOrderReception => 'التحكم في استقبال الطلبات';

  @override
  String get currentPhoneLabel => 'رقم الجوال الحالي';

  @override
  String get newPhoneLabel => 'رقم الجوال الجديد';

  @override
  String get verifyPhoneButton => 'تأكيد';

  @override
  String get enterCurrentPhone => 'أدخل رقم جوالك الحالي';

  @override
  String get enterNewPhone => 'أدخل رقم جوالك الجديد';

  @override
  String get invalidPhone => 'رقم الجوال غير صحيح';

  @override
  String get phoneChangedSuccess => 'تم تحديث رقم الجوال بنجاح';
}
