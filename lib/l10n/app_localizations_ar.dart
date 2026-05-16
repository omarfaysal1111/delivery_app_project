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
  String get loginSubtitle => 'مرحبا بعودتك مره اخرى سجل دخول الان !';

  @override
  String get loginPhoneLabel => 'رقم الجوال';

  @override
  String get loginPhoneHint => 'رقم الجوال';

  @override
  String get loginSubmit => 'تسجيل دخول';

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
  String get registerWelcomeSubtitle =>
      'انضم إلينا اليوم واستمتع بتجربة توصيل أسرع';

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
  String get validationDocumentRequired => 'يرجى رفع هذا المستند';

  @override
  String get validationProfilePhotoRequired => 'الصورة الشخصية مطلوبة';

  @override
  String get validationOtpRequired => 'رمز التحقق مطلوب';

  @override
  String get validationOtpSixDigits => 'يرجى إدخال ٦ أرقام';
}
