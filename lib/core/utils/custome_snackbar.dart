import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_app/core/Theme/app_color.dart';

class CustomeSnackbar {
  static void _showSnackBar(BuildContext context, String message, Color color) {
    WidgetsBinding.instance.addPostFrameCallback((_) => {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                message,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: AppColor.whiteColor),
              ),
              backgroundColor: color,
            ),
          ),
        });
  }

  static void showError(BuildContext context, String message) {
    _showSnackBar(context, message, AppColor.snakBarRed);
  }

  static void showInfo(BuildContext context, String message) {
    _showSnackBar(context, message, AppColor.snakBarBlue);
  }

  static void showSuccess(BuildContext context, String message) {
    _showSnackBar(context, message, AppColor.snakBarGreen);
  }
}
