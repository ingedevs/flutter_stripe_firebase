import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText, labelText, errorMessage;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final void Function(String)? onChanged;
  final Widget? suffixIcon, suffix, prefixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final EdgeInsetsGeometry? margin;

  const CustomTextField({
    this.hintText,
    this.labelText,
    this.errorMessage,
    this.controller,
    this.onTap,
    this.onChanged,
    this.suffixIcon,
    this.suffix,
    this.prefixIcon,
    this.inputFormatters,
    this.focusNode,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.margin = EdgeInsets.zero,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: TextFormField(
        onTap: onTap,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: onChanged,
        controller: controller,
        focusNode: focusNode,
        canRequestFocus: onTap == null,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        validator: validator,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          suffix: suffix,
          errorText: errorMessage,
        ),
      ),
    );
  }
}
