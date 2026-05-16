import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/localization/context_locale_ext.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/utils/auth_form_validation.dart';
import '../../../../core/utils/auth_validators.dart';
import '../../../../l10n/app_localizations.dart';
import '../widgets/app_language_picker_modal.dart';
import '../widgets/auth_image_upload_box.dart';
import '../widgets/auth_language_chip_align.dart';
import '../widgets/auth_primary_button.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/document_upload_tile.dart';
import '../widgets/phone_number_field.dart';
import '../widgets/vehicle_type_field.dart';

class RegisterDriverPage extends StatefulWidget {
  const RegisterDriverPage({super.key});

  @override
  State<RegisterDriverPage> createState() => _RegisterDriverPageState();
}

class _RegisterDriverPageState extends State<RegisterDriverPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _nationalIdController = TextEditingController();
  final _picker = ImagePicker();

  String? _vehicleType;
  bool _hasAttemptedSubmit = false;

  static const _vehicleTypes = ['motorcycle', 'car', 'bicycle'];

  @override
  void dispose() {
    _usernameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _nationalIdController.dispose();
    super.dispose();
  }

  String _vehicleLabel(AppLocalizations l10n, String key) {
    switch (key) {
      case 'motorcycle':
        return l10n.vehicleTypeMotorcycle;
      case 'car':
        return l10n.vehicleTypeCar;
      case 'bicycle':
        return l10n.vehicleTypeBicycle;
      default:
        return key;
    }
  }

  Future<File?> _pickImageFile() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked == null) return null;
    return File(picked.path);
  }

  void _onRegisterPressed() {
    FocusScope.of(context).unfocus();

    if (!_hasAttemptedSubmit) {
      setState(() => _hasAttemptedSubmit = true);
    }

    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    context.go(RouteNames.registrationPending);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final fieldAutovalidate = authAutovalidateMode(_hasAttemptedSubmit);

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground(context),
      bottomNavigationBar: SafeArea(
        child: Container(
          color: AppColors.surfaceCard(context),
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
          child: AuthPrimaryButton(
            label: l10n.registerSubmit,
            onPressed: _onRegisterPressed,
          ),
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
              AuthLanguageChipAlign(
                label: context.isArabic
                    ? l10n.languageArabicChip
                    : l10n.languageEnglishChip,
                flagAsset:
                    context.isArabic ? AppAssets.flagEg : AppAssets.flagUsa,
                onTap: () => showAppLanguagePicker(context),
              ),
              const SizedBox(height: 16),
              Text(
                l10n.registerWelcomeTitle,
                textAlign: TextAlign.start,
                style: AppTextStyles.screenTitle(context),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.registerWelcomeSubtitle,
                textAlign: TextAlign.start,
                style: AppTextStyles.subtitle(context),
              ),
              const SizedBox(height: 24),
              _ProfilePhotoFormField(
                fieldKey: const ValueKey('register_profile_photo'),
                label: l10n.registerProfilePhotoLabel,
                requiredMessage: l10n.validationProfilePhotoRequired,
                autovalidateMode: fieldAutovalidate,
                onPick: _pickImageFile,
              ),
              const SizedBox(height: 20),
              AuthTextField(
                key: const ValueKey('register_username'),
                controller: _usernameController,
                label: l10n.registerUsernameLabel,
                hintText: l10n.registerUsernameHint,
                autovalidateMode: fieldAutovalidate,
                validator: (v) => AuthValidators.usernameRegister(
                  v,
                  requiredMessage: l10n.validationUsernameRequired,
                  minMessage: l10n.validationUsernameMin3,
                ),
              ),
              const SizedBox(height: 20),
              PhoneNumberField(
                key: const ValueKey('register_phone'),
                controller: _phoneController,
                label: l10n.registerPhoneLabel,
                hintText: l10n.registerPhoneHint,
                autovalidateMode: fieldAutovalidate,
                validator: (v) => AuthValidators.egyptianPhone(
                  v,
                  requiredMessage: l10n.validationPhoneRequired,
                  invalidMessage: l10n.validationPhoneEgyptian,
                ),
              ),
              const SizedBox(height: 20),
              AuthTextField(
                key: const ValueKey('register_email'),
                controller: _emailController,
                label: l10n.registerEmailLabel,
                hintText: l10n.registerEmailHint,
                keyboardType: TextInputType.emailAddress,
                autovalidateMode: fieldAutovalidate,
                validator: (v) => AuthValidators.emailBasic(
                  v,
                  requiredMessage: l10n.validationEmailRequired,
                  invalidMessage: l10n.validationEmailInvalid,
                ),
              ),
              const SizedBox(height: 20),
              AuthTextField(
                key: const ValueKey('register_national_id'),
                controller: _nationalIdController,
                label: l10n.registerNationalIdLabel,
                hintText: l10n.registerNationalIdHint,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                autovalidateMode: fieldAutovalidate,
                validator: (v) => AuthValidators.egyptianNationalId(
                  v,
                  requiredMessage: l10n.validationNationalIdRequired,
                  invalidMessage: l10n.validationNationalIdInvalid,
                ),
              ),
              const SizedBox(height: 20),
              VehicleTypeField(
                key: const ValueKey('register_vehicle_type'),
                label: l10n.registerVehicleTypeLabel,
                hintText: l10n.registerVehicleTypeHint,
                items: _vehicleTypes,
                itemLabelBuilder: (t) => _vehicleLabel(l10n, t),
                initialValue: _vehicleType,
                autovalidateMode: fieldAutovalidate,
                validator: (v) => AuthValidators.requiredSelection(
                  v,
                  requiredMessage: l10n.validationVehicleTypeRequired,
                ),
                onChanged: (v) => setState(() => _vehicleType = v),
              ),
              const SizedBox(height: 20),
              _DocumentUploadFormField(
                fieldKey: const ValueKey('register_driving_license'),
                label: l10n.registerUploadDrivingLicense,
                hintText: l10n.registerUploadDrivingLicense,
                tapToUploadLabel: l10n.uploadTapToUpload,
                requiredMessage: l10n.validationDocumentRequired,
                autovalidateMode: fieldAutovalidate,
                onPick: _pickImageFile,
              ),
              const SizedBox(height: 20),
              _DocumentUploadFormField(
                fieldKey: const ValueKey('register_vehicle_license'),
                label: l10n.registerUploadVehicleLicense,
                hintText: l10n.registerUploadVehicleLicense,
                tapToUploadLabel: l10n.uploadTapToUpload,
                requiredMessage: l10n.validationDocumentRequired,
                autovalidateMode: fieldAutovalidate,
                onPick: _pickImageFile,
              ),
              const SizedBox(height: 20),
              _DocumentUploadFormField(
                fieldKey: const ValueKey('register_national_id_doc'),
                label: l10n.registerUploadNationalId,
                hintText: l10n.registerUploadNationalId,
                tapToUploadLabel: l10n.uploadTapToUpload,
                requiredMessage: l10n.validationDocumentRequired,
                autovalidateMode: fieldAutovalidate,
                onPick: _pickImageFile,
              ),
            ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ProfilePhotoFormField extends StatelessWidget {
  const _ProfilePhotoFormField({
    required this.fieldKey,
    required this.label,
    required this.requiredMessage,
    required this.autovalidateMode,
    required this.onPick,
  });

  final Key fieldKey;
  final String label;
  final String requiredMessage;
  final AutovalidateMode autovalidateMode;
  final Future<File?> Function() onPick;

  @override
  Widget build(BuildContext context) {
    return FormField<File>(
      key: fieldKey,
      autovalidateMode: autovalidateMode,
      validator: (file) =>
          file == null ? requiredMessage : null,
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: AppTextStyles.fieldLabel(context),
              ),
            ),
            const SizedBox(height: 8),
            AuthImageUploadBox(
              imageFile: field.value,
              hasError: field.hasError,
              onTap: () async {
                final file = await onPick();
                if (file != null) {
                  field.didChange(file);
                }
              },
            ),
            if (field.hasError)
              Padding(
                padding: const EdgeInsetsDirectional.only(top: 6),
                child: Text(
                  field.errorText ?? '',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.validationCaption,
                ),
              ),
          ],
        );
      },
    );
  }
}

class _DocumentUploadFormField extends StatelessWidget {
  const _DocumentUploadFormField({
    required this.fieldKey,
    required this.label,
    required this.hintText,
    required this.tapToUploadLabel,
    required this.requiredMessage,
    required this.autovalidateMode,
    required this.onPick,
  });

  final Key fieldKey;
  final String label;
  final String hintText;
  final String tapToUploadLabel;
  final String requiredMessage;
  final AutovalidateMode autovalidateMode;
  final Future<File?> Function() onPick;

  @override
  Widget build(BuildContext context) {
    return FormField<File>(
      key: fieldKey,
      autovalidateMode: autovalidateMode,
      validator: (file) =>
          file == null ? requiredMessage : null,
      builder: (field) {
        return DocumentUploadTile(
          label: label,
          hintText: hintText,
          tapToUploadLabel: tapToUploadLabel,
          imageFile: field.value,
          hasError: field.hasError,
          errorText: field.hasError ? field.errorText : null,
          onTap: () async {
            final file = await onPick();
            if (file != null) {
              field.didChange(file);
            }
          },
          onRemove: () => field.didChange(null),
        );
      },
    );
  }
}
