import 'package:flutter/material.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/widgets/app_media.dart';

/// Custom vehicle-type dropdown matching the Figma design.
///
/// - Label above the field (text-start aligned).
/// - Tappable closed field: hint/value text + arrow on the directional start.
/// - Inline list below the field that expands/collapses with animation.
/// - Same width as the field. Connected visual feel.
/// - Plays a real [FormField] so validation works with the surrounding [Form].
class VehicleTypeField extends StatefulWidget {
  const VehicleTypeField({
    super.key,
    required this.label,
    required this.hintText,
    required this.items,
    required this.itemLabelBuilder,
    required this.validator,
    required this.autovalidateMode,
    this.initialValue,
    this.onChanged,
  });

  final String label;
  final String hintText;
  final List<String> items;
  final String Function(String value) itemLabelBuilder;
  final String? Function(String?)? validator;
  final AutovalidateMode autovalidateMode;
  final String? initialValue;
  final ValueChanged<String?>? onChanged;

  @override
  State<VehicleTypeField> createState() => _VehicleTypeFieldState();
}

class _VehicleTypeFieldState extends State<VehicleTypeField> {
  bool _isOpen = false;

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      initialValue: widget.initialValue,
      autovalidateMode: widget.autovalidateMode,
      validator: widget.validator,
      builder: (field) {
        final hasError = field.hasError;
        final borderColor = hasError
            ? AppColors.fieldError(context)
            : AppColors.border(context);
        final selected = field.value;
        final hasValue = selected != null && selected.isNotEmpty;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.label,
              textAlign: TextAlign.start,
              style: AppTextStyles.fieldLabel(context),
            ),
            const SizedBox(height: 8),
            Material(
              color: AppColors.surfaceCard(context),
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () => setState(() => _isOpen = !_isOpen),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceCard(context),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: borderColor, width: 0.5),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          hasValue
                              ? widget.itemLabelBuilder(selected)
                              : widget.hintText,
                          textAlign: TextAlign.start,
                          style: hasValue
                              ? AppTextStyles.inputText(context)
                              : AppTextStyles.inputHint(context),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      const SizedBox(width: 8),
                      AnimatedRotation(
                        turns: _isOpen ? 0.5 : 0,
                        duration: const Duration(milliseconds: 180),
                        child: AppSvgImage.asset(
                          AppAssets.icArrowDown,
                          width: 16,
                          height: 16,
                          color: AppColors.paragraph(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeOut,
              alignment: AlignmentDirectional.topStart,
              child: _isOpen
                  ? Padding(
                      padding: const EdgeInsetsDirectional.only(top: 6),
                      child: _OptionsList(
                        items: widget.items,
                        selected: field.value,
                        itemLabelBuilder: widget.itemLabelBuilder,
                        onTap: (value) {
                          field.didChange(value);
                          widget.onChanged?.call(value);
                          setState(() => _isOpen = false);
                        },
                      ),
                    )
                  : const SizedBox(width: double.infinity),
            ),
            if (hasError)
              Padding(
                padding: const EdgeInsetsDirectional.only(top: 6),
                child: Text(
                  field.errorText ?? '',
                  textAlign: TextAlign.start,
                  style: AppTextStyles.validationCaption,
                ),
              ),
          ],
        );
      },
    );
  }
}

class _OptionsList extends StatelessWidget {
  const _OptionsList({
    required this.items,
    required this.selected,
    required this.itemLabelBuilder,
    required this.onTap,
  });

  final List<String> items;
  final String? selected;
  final String Function(String value) itemLabelBuilder;
  final ValueChanged<String> onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surfaceCard(context),
      borderRadius: BorderRadius.circular(10),
      clipBehavior: Clip.antiAlias,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surfaceCard(context),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.border(context), width: 0.5),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var i = 0; i < items.length; i++) ...[
              if (i > 0)
                Divider(
                  height: 0.5,
                  thickness: 0.5,
                  color: AppColors.border(context),
                ),
              InkWell(
                onTap: () => onTap(items[i]),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  child: Text(
                    itemLabelBuilder(items[i]),
                    textAlign: TextAlign.start,
                    style: items[i] == selected
                        ? AppTextStyles.inputText(context).copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          )
                        : AppTextStyles.inputText(context),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
