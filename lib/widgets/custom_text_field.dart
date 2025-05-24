import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:messenger/constants/app_colors.dart';
import 'package:messenger/constants/app_text_styles.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? textEditingController;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final void Function(String)? onSubmitted;
  final int maxLetters, maxLines;
  final bool autofocus, textCenter, enabled, hideText;
  final int? minLines;
  final String? hint, initialValue;
  final TextInputType? inputType;
  final Icon? prefixIcon;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;

  const CustomTextField({
    super.key,
    this.textEditingController,
    this.maxLetters = 155,
    this.maxLines = 1,
    this.inputType,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.autofocus = false,
    this.textCenter = false,
    this.minLines = 1,
    this.hint,
    this.initialValue,
    this.enabled = true,
    this.hideText = false,
    this.prefixIcon,
    this.focusNode,
    this.textInputAction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightGreen,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TextFormField(
        enabled: enabled,
        initialValue: initialValue,
        autofocus: autofocus,
        controller: textEditingController,
        onChanged: onChanged,
        onFieldSubmitted: onSubmitted,
        validator: validator,
        maxLength: maxLetters,
        maxLines: maxLines,
        minLines: minLines,
        textAlign: textCenter ? TextAlign.center : TextAlign.left,
        keyboardType: inputType,
        obscureText: hideText,
        focusNode: focusNode,
        textInputAction: textInputAction,
        style: AppTextStyles.s20.copyWith(
          fontWeight: FontWeight.w600
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: prefixIcon,
          counterText: '',
          isDense: true,
          hintText: hint,
          hintStyle: AppTextStyles.s20.copyWith(
            fontWeight: FontWeight.w500,
            color: AppColors.darkGreen
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 16.h,
          ),
        ),
      ),
    );
  }
}
