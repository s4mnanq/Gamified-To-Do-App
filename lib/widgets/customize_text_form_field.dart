import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CustomizeTextFormField extends StatelessWidget {
  const CustomizeTextFormField({
    super.key,
    required this.controller,
    this.obscureText = false,
    this.enabled = true,
    this.textInputType,
    this.validator,
    this.focusNode,
    this.onChanged,
    this.textStyle,
    this.onEditingComplete,
    this.initialValue,
    this.inputFormatters,
    this.decoration,
    this.hintText,
    this.labelText,
  });

  final TextEditingController controller;
  final bool obscureText;
  final bool enabled;
  final TextInputType? textInputType;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextStyle? textStyle;
  final VoidCallback? onEditingComplete;
  final String? initialValue;
  final List<TextInputFormatter>? inputFormatters;
  final InputDecoration? decoration;
  final String? hintText;
  final String? labelText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      clipBehavior: Clip.hardEdge,
      obscureText: obscureText,
      enabled: enabled,
      keyboardType: textInputType,
      validator: validator,
      focusNode: focusNode,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      initialValue: initialValue,
      inputFormatters: inputFormatters ?? [],
      style: textStyle ?? context.textTheme.bodyMedium,
      decoration:
          decoration ??
          InputDecoration(
            border: OutlineInputBorder(
              borderSide: .none,
              borderRadius: .circular(12),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: .none,
              borderRadius: .circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: .none,
              borderRadius: .circular(12),
            ),
            contentPadding: const .symmetric(horizontal: 12, vertical: 14),
            filled: true,
            fillColor: context.theme.inputDecorationTheme.fillColor,
            hintText: hintText,
            labelText: labelText,
          ),
    );
  }
}
