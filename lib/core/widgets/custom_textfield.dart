import 'package:flutter/material.dart';
import 'package:todo/core/utils/extentions.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.controller,
      required this.label,
      this.textInputType = TextInputType.text,
      this.obscureText = false,
      required this.hintText,
      this.validator,
      this.maxLength, this.maxLine});
  final TextEditingController controller;
  final String label;
  final TextInputType textInputType;
  final bool obscureText;
  final String hintText;
  final String? Function(String? value)? validator;
  final int? maxLength;
  final int? maxLine;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: context.theme.textTheme.titleMedium!
              .copyWith(fontWeight: FontWeight.w600),
        ),
        8.hs,
        TextFormField(
          controller: controller,
          keyboardType: textInputType,
          obscureText: obscureText,
          style: context.theme.textTheme.titleMedium,
          validator: validator,
          maxLength: maxLength,
          maxLines: maxLine,
          decoration: InputDecoration(
              counterText: "",
              hintText: hintText,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        ),
      ],
    );
  }
}