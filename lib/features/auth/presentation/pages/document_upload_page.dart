import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/router/route_names.dart';
import '../../../../core/utils/auth_form_validation.dart';
import '../../../../l10n/app_localizations.dart';
import '../widgets/auth_back_button.dart';
import '../widgets/auth_primary_button.dart';
import '../widgets/auth_scaffold.dart';
import '../widgets/document_upload_tile.dart';

/// Standalone document upload (same tiles as register). UI preview only.
class DocumentUploadPage extends StatefulWidget {
  const DocumentUploadPage({super.key});

  @override
  State<DocumentUploadPage> createState() => _DocumentUploadPageState();
}

class _DocumentUploadPageState extends State<DocumentUploadPage> {
  final _formKey = GlobalKey<FormState>();
  final _picker = ImagePicker();
  bool _hasAttemptedSubmit = false;

  Future<File?> _pickImageFile() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked == null) return null;
    return File(picked.path);
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    if (!_hasAttemptedSubmit) {
      setState(() => _hasAttemptedSubmit = true);
    }
    if (!(_formKey.currentState?.validate() ?? false)) return;
    context.go(RouteNames.registrationPending);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final autovalidate = authAutovalidateMode(_hasAttemptedSubmit);

    return AuthScaffold(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const AuthBackButton(),
            const SizedBox(height: 24),
            _DocumentUploadFormField(
              fieldKey: const ValueKey('doc_driving_license'),
              label: l10n.registerUploadDrivingLicense,
              tapToUploadLabel: l10n.uploadTapToUpload,
              requiredMessage: l10n.validationDocumentRequired,
              autovalidateMode: autovalidate,
              onPick: _pickImageFile,
            ),
            const SizedBox(height: 20),
            _DocumentUploadFormField(
              fieldKey: const ValueKey('doc_vehicle_license'),
              label: l10n.registerUploadVehicleLicense,
              tapToUploadLabel: l10n.uploadTapToUpload,
              requiredMessage: l10n.validationDocumentRequired,
              autovalidateMode: autovalidate,
              onPick: _pickImageFile,
            ),
            const SizedBox(height: 20),
            _DocumentUploadFormField(
              fieldKey: const ValueKey('doc_national_id'),
              label: l10n.registerUploadNationalId,
              tapToUploadLabel: l10n.uploadTapToUpload,
              requiredMessage: l10n.validationDocumentRequired,
              autovalidateMode: autovalidate,
              onPick: _pickImageFile,
            ),
            const SizedBox(height: 32),
            AuthPrimaryButton(
              label: l10n.registerSubmit,
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }
}

class _DocumentUploadFormField extends StatelessWidget {
  const _DocumentUploadFormField({
    required this.fieldKey,
    required this.label,
    required this.tapToUploadLabel,
    required this.requiredMessage,
    required this.autovalidateMode,
    required this.onPick,
  });

  final Key fieldKey;
  final String label;
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
          hintText: label,
          tapToUploadLabel: tapToUploadLabel,
          imageFile: field.value,
          hasError: field.hasError,
          errorText: field.hasError ? field.errorText : null,
          onTap: () async {
            final file = await onPick();
            if (file != null) field.didChange(file);
          },
          onRemove: () => field.didChange(null),
        );
      },
    );
  }
}
