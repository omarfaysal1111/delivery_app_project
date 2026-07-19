import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/localization/app_locale_scope.dart';
import '../../../../l10n/app_localizations.dart';

class LanguagePickerSheet extends StatefulWidget {
  const LanguagePickerSheet({super.key});

  @override
  State<LanguagePickerSheet> createState() => _LanguagePickerSheetState();
}

class _LanguagePickerSheetState extends State<LanguagePickerSheet> {
  late String _selectedLanguage;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _selectedLanguage = AppLocaleScope.of(context).locale.languageCode;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.only(
        top: 16.0,
        bottom: 20.0,
        start: 16.0,
        end: 16.0,
      ),
      decoration: BoxDecoration(
        color: AppColors.languageModalBackground(context),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12.0)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              AppLocalizations.of(context)!.changeAppLanguageTitle,
              style: AppTextStyles.heading4(context).copyWith(
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Divider(color: AppColors.border(context), height: 1),
            const SizedBox(height: 16),
            _buildOption('عربي', 'ar'),
            const SizedBox(height: 16),
            Divider(color: AppColors.border(context), height: 1),
            const SizedBox(height: 16),
            _buildOption('English', 'en'),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(String label, String value) {
    final isSelected = _selectedLanguage == value;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedLanguage = value;
        });
        AppLocaleScope.of(context).setLocale(Locale(value));
        Navigator.pop(context);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 20,
            height: 20,
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? AppColors.onSurface(context) : AppColors.hint(context),
                width: 2,
              ),
            ),
            child: isSelected
                ? Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.onSurface(context),
                    ),
                  )
                : null,
          ),
          const SizedBox(width: 12),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'ExpoArabic',
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
              color: isSelected ? AppColors.onSurface(context) : AppColors.paragraph(context),
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> showLanguagePicker(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: AppColors.modalBarrierScrim(context),
    builder: (context) => const LanguagePickerSheet(),
  );
}
