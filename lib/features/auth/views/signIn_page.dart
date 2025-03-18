import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/core/Theme/app_color.dart';
import 'package:todo_app/core/routes/name_routes.dart';
import 'package:todo_app/core/utils/app_image_url.dart';
import 'package:todo_app/core/utils/app_string.dart';
import 'package:todo_app/core/utils/validation_rules.dart';
import 'package:todo_app/core/widget/custome_text_form_field.dart';
import 'package:todo_app/core/widget/rounded_button.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final _registerFormKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isPasswordVisible = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Form(
              key: _registerFormKey,
              child: Column(
                children: [
                  Image.asset(
                    AppImageUrl.logo,
                    width: 100,
                    height: 100,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomeTextFormField(
                      controller: _firstNameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppString.required;
                        }
                        return null;
                      },
                      keyboardType: TextInputType.name,
                      obscureText: false,
                      hintText: AppString.firstName,
                      suffix: null),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomeTextFormField(
                      controller: _lastNameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppString.required;
                        }
                        return null;
                      },
                      keyboardType: TextInputType.name,
                      obscureText: false,
                      hintText: AppString.lastName,
                      suffix: null),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomeTextFormField(
                      controller: _emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppString.required;
                        } else if (!ValidationRules.emailValidation
                            .hasMatch(value)) {
                          return AppString.provideVlaidEmail;
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      obscureText: false,
                      hintText: AppString.email,
                      suffix: null),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomeTextFormField(
                    controller: _passwordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppString.required;
                      }
                      return null;
                    },
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: !isPasswordVisible,
                    hintText: AppString.password,
                    suffix: InkWell(
                      onTap: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                      child: Icon(
                        isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: AppColor.greyColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  RoundedButton(
                      buttonText: AppString.register,
                      onPressed: () {
                        if (_registerFormKey.currentState!.validate()) {}
                      },
                      color: AppColor.appColor),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      context.pushNamed(RoutesName.login);
                    },
                    child: RichText(
                      text: TextSpan(
                        text: AppString.alreadyRegisterThisAccount,
                        style: TextStyle(color: AppColor.greyColor),
                        children: [
                          TextSpan(
                            text: AppString.login,
                            style: TextStyle(color: AppColor.appColor),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
