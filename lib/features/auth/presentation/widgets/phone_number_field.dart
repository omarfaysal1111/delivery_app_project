import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/localization/context_locale_ext.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/widgets/app_media.dart';

/// Phone field with Egypt +20 prefix locked on the physical LEFT (LTR island).
class PhoneNumberField extends StatelessWidget {
  const PhoneNumberField({
    super.key,
    required this.controller,
    required this.label,
    required this.hintText,
    this.validator,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
  });

  final TextEditingController controller;
  final String label;
  final String hintText;
  final String? Function(String?)? validator;
  final AutovalidateMode autovalidateMode;

  @override
  Widget build(BuildContext context) {
    final isArabic = context.isArabic;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          textAlign: TextAlign.start,
          style: AppTextStyles.fieldLabel(context),
        ),
        const SizedBox(height: 8),
        FormField<String>(
          key: key,
          validator: (_) => validator?.call(controller.text),
          autovalidateMode: autovalidateMode,
          builder: (field) {
            final borderColor = field.hasError
                ? AppColors.fieldError(context)
                : AppColors.border(context);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceCard(context),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: borderColor, width: 0.5),
                  ),
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: Row(
                      children: [
                        const _PhoneCountryPrefix(),
                        Expanded(
                          child: Directionality(
                            textDirection: isArabic
                                ? TextDirection.rtl
                                : TextDirection.ltr,
                            child: TextField(
                              controller: controller,
                              keyboardType: TextInputType.phone,
                              textAlign: TextAlign.start,
                              style: AppTextStyles.inputText(context),
                              cursorColor: AppColors.cursor(context),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              decoration: InputDecoration(
                                hintText: hintText,
                                hintStyle: AppTextStyles.inputHint(context),
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 14,
                                ),
                                isDense: true,
                              ),
                              onChanged: field.didChange,
                              onTapOutside: (_) =>
                                  FocusScope.of(context).unfocus(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (field.hasError)
                  Padding(
                    padding: const EdgeInsetsDirectional.only(top: 6),
                    child: Text(
                      field.errorText ?? '',
                      style: AppTextStyles.validationCaption,
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}

/// Flag + +20 + divider (parent [Row] is forced LTR).
class _PhoneCountryPrefix extends StatelessWidget {
  const _PhoneCountryPrefix();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppSvgImage.asset(AppAssets.flagEg, width: 16, height: 16),
          const SizedBox(width: 4),
          Text(
            '+20',
            style: AppTextStyles.inputHint(context).copyWith(
              color: AppColors.paragraph(context),
            ),
          ),
          const SizedBox(width: 8),
          AppSvgImage.asset(
            AppAssets.icPhoneDivider,
            width: 1,
            height: 16,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}
