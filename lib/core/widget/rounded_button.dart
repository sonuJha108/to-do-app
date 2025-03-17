import 'package:flutter/material.dart';
import 'package:todo_app/core/Theme/app_color.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    required this.color,
  });

  final String buttonText;
  final Function()? onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(color),
        elevation: const WidgetStatePropertyAll(0),
        shape: const WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
        ),
        fixedSize:
            WidgetStatePropertyAll(Size(MediaQuery.sizeOf(context).width, 45)),
      ),
      child: Text(
        buttonText,
        style: const TextStyle(
            color: AppColor.whiteColor,
            fontWeight: FontWeight.w400,
            fontSize: 16),
      ),
    );
  }
}
