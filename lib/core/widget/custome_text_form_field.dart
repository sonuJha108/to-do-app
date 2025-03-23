import 'package:flutter/material.dart';
import 'package:todo_app/core/Theme/app_color.dart';

// create the custome form like text box and re-using the code.
class CustomeTextFormField extends StatelessWidget {
  // A contructor and all fields are require.
  const CustomeTextFormField({
    super.key,
    required this.controller,
    required this.validator,
    required this.keyboardType,
    required this.obscureText,
    required this.hintText,
    required this.suffix,
  });

  // create the all fields required datas.
  final TextEditingController controller;
  final String? Function(String? val) validator;
  final TextInputType keyboardType;
  final bool obscureText;
  final String hintText;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    // text form field widget.
    return TextFormField(
      // password is show or not.
      obscureText: obscureText,
      autovalidateMode: AutovalidateMode.onUserInteraction,

      // its controlle the text fields.
      controller: controller,
      // style the text form fields.
      style: Theme.of(context).textTheme.titleMedium,

      // the keyboard types.
      keyboardType: keyboardType,
      decoration: InputDecoration(
        suffix: suffix,
        hintText: hintText,
        hintStyle: const TextStyle(fontWeight: FontWeight.bold),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.borderColor, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        // if the border is enable.
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: AppColor.borderColor,
          ),
          // show the border radius in the text form fields.
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: AppColor.appColor),
        ),
        // when its show the error in the app.
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.errorColor, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        // focus on the border in the app.
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.errorColor, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        // when its show the error of the app.
        errorStyle: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(color: AppColor.errorColor, fontSize: 12),
      ),
      // A validator check the data is valid or not.
      validator: validator,
    );
  }
}
