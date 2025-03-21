import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/core/Theme/app_color.dart';
import 'package:todo_app/core/routes/name_routes.dart';
import 'package:todo_app/core/utils/app_image_url.dart';
import 'package:todo_app/core/utils/app_string.dart';
import 'package:todo_app/core/utils/custome_snackbar.dart';
import 'package:todo_app/core/utils/full_screen_dialog_loader.dart';
import 'package:todo_app/core/utils/validation_rules.dart';
import 'package:todo_app/core/widget/custome_text_form_field.dart';
import 'package:todo_app/core/widget/rounded_button.dart';
import 'package:todo_app/features/auth/cubit/register_cubit.dart';

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

  clearText() {
    _firstNameController.clear();
    _lastNameController.clear();
    _emailController.clear();
    _passwordController.clear();
  }

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
            child: BlocConsumer<RegisterCubit, RegisterState>(
              listener: (context, state) {
                if (state is RegisterLoading) {
                  FullScreenDialogLoader.show(context);
                } else if (state is RegisterSuccess) {
                  clearText();
                  FullScreenDialogLoader.show(context);
                  CustomeSnackbar.showSuccess(context, AppString.accountCreate);
                  context.goNamed(RoutesName.login);
                } else if (state is RegisterError) {
                  CustomeSnackbar.showError(context, state.error);
                }
              },
              builder: (context, state) {
                return Form(
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
                            if (_registerFormKey.currentState!.validate()) {
                              context.read<RegisterCubit>().register(
                                  firstName: _firstNameController.text,
                                  lastName: _lastNameController.text,
                                  email: _emailController.text,
                                  password: _passwordController.text);
                            }
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
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
