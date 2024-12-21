import 'package:flutter/material.dart';
import 'package:art_gallery/core/utils/app_textstyles.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      required this.hintText,
      required this.textInputType,
      this.suffixIcon,
      this.onSaved,
      this.obscureText = false,
      this.validator,
      this.readOnly = false,
      this.onTap,
      this.onPrefixWidget,
      this.prefixWidget,
      this.length,
      this.controller,
      this.maxLines,
      this.initialValue,
      this.enabled});
  final TextEditingController? controller;
  final String hintText;
  final TextInputType textInputType;
  final Widget? suffixIcon;
  final Function(String?)? onSaved;
  final bool obscureText;
  final String? Function(String?)? validator;
  final VoidCallback? onTap;
  final VoidCallback? onPrefixWidget;
  final int? length;
  final String? initialValue;
  final bool readOnly;
  final Widget? prefixWidget;

  final int? maxLines;
  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // maxLines: maxLines,
      enabled: enabled,
      initialValue: initialValue,
      controller: controller,
      onSaved: onSaved,
      obscureText: obscureText,
      onTap: onTap,
      readOnly: readOnly,
      maxLength: length,
      validator: validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return "This field is requied";
            }
            return null;
          },
      keyboardType: textInputType,
      decoration: InputDecoration(
        counterText: '',
        prefixIcon: prefixWidget,
        suffixIcon: suffixIcon,
        hintText: hintText,
        filled: true,
        hintStyle: TextStyles.bold13.copyWith(
          color: const Color(0XFF949D9E),
        ),
        fillColor: const Color(0xFFF9FAFA),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(
            width: 1,
            color: Color(0xFFE6E9E9),
          ),
        ),
      ),
    );
  }
}
