import 'package:flutter/material.dart';
import 'package:todo_app/core/Theme/app_color.dart';

class CustomeTextFormField extends StatelessWidget {
  const CustomeTextFormField({
    super.key,
    required this.controller,
    required this.validator,
    required this.keyboardType,
    required this.obscureText,
    required this.hintText,
    required this.suffix,
  });

  final TextEditingController controller;
  final String? Function(String? val) validator;
  final TextInputType keyboardType;
  final bool obscureText;
  final String hintText;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      style: Theme.of(context).textTheme.titleMedium,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        suffix: suffix,
        hintText: hintText,
        hintStyle: const TextStyle(fontWeight: FontWeight.bold),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.borderColor, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: AppColor.borderColor,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: AppColor.appColor),
        ),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.errorColor, width: 1),
            borderRadius: BorderRadius.circular(10)),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.errorColor, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        errorStyle: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(color: AppColor.errorColor, fontSize: 12),
      ),
      validator: validator,
    );
  }
}
