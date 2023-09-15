import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quix_note/src/utils/app_colors.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    this.borderColor,
    Key? key,
    this.hint,
    this.onTap,
    this.label,
    this.value,
    this.obscure = false,
    this.suffix,
    this.onSaved,
    this.onChanged,
    this.readonly = false,
    this.validator,
    this.keyboardType,
    this.floatLabel = false,
    this.textEditingController,
    this.isBold = false,
    this.maxLines = 1,
    this.minLines = 1,
    this.textInputAction = TextInputAction.next,
    this.fillColor,
    this.style,
    this.bottomPadding,
    this.prefix,
    this.hintStyle,
    this.hintColor,
    this.showBorder = true,
    this.contentPadding = const EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 17,
    ),
    this.borderRadius,
    this.focusNode,
    this.inputFormatters,
    this.cursorColor,
    this.maxLength,
    this.border,
    this.textCapitalization = TextCapitalization.none,
    this.initialVal,
    this.onEditingComplete,
  }) : super(key: key);

  final Color? cursorColor;
  final FocusNode? focusNode;
  final EdgeInsets contentPadding;
  final bool? isBold;
  final double? bottomPadding;
  final TextStyle? style;
  final bool? obscure;
  final String? hint;
  final String? label;
  final String? value;
  final bool readonly;
  final Widget? suffix;
  final bool? floatLabel;
  final VoidCallback? onTap;
  final VoidCallback? onEditingComplete;
  final TextInputType? keyboardType;
  final FormFieldSetter<String>? onSaved;
  final FormFieldSetter<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final TextEditingController? textEditingController;
  final int? maxLines;
  final int? minLines;
  final Color? fillColor;
  final TextInputAction? textInputAction;

  final Widget? prefix;
  final TextStyle? hintStyle;
  final Color? hintColor;
  final bool showBorder;
  final double? borderRadius;
  final Color? borderColor;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final TextCapitalization textCapitalization;
  final InputBorder? border;
  final String? initialVal;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding ?? 15),
      child: TextFormField(
        textAlignVertical: TextAlignVertical.center,
        textCapitalization: textCapitalization,
        onTap: onTap,
        onEditingComplete: onEditingComplete,
        textAlign: TextAlign.left,
        initialValue: initialVal,
        maxLength: maxLength,
        minLines: minLines,
        onSaved: onSaved,
        focusNode: focusNode,
        onChanged: onChanged,
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        validator: validator,
        obscureText: obscure ?? false,
        maxLines: maxLines ?? 1,
        controller: textEditingController,
        decoration: InputDecoration(
          filled: true,
          fillColor: fillColor,
          prefixIconColor: AppColors.darkTeal,
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.lightYellow),
            borderRadius: BorderRadius.all(
              Radius.circular(borderRadius ?? 8.0),
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.lightYellow),
            borderRadius: BorderRadius.all(
              Radius.circular(borderRadius ?? 8.0),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.lightYellow),
            borderRadius: BorderRadius.all(
              Radius.circular(borderRadius ?? 8.0),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.lightYellow),
            borderRadius: BorderRadius.all(
              Radius.circular(borderRadius ?? 8.0),
            ),
          ),
          contentPadding: contentPadding,
          prefixIcon: prefix,
          suffixIcon: suffix,
          labelText: label,
          hintText: hint ?? '',
          hintStyle: hintStyle ??
              textTheme.bodyMedium!.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: AppColors.darkGrey,
              ),
          labelStyle: textTheme.bodyMedium!.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            // color: AppColors.primary,
          ),
        ),
      ),
    );
  }
}
