import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/core/Theme/app_color.dart';
import 'package:todo_app/core/locators/locators.dart';
import 'package:todo_app/core/routes/name_routes.dart';
import 'package:todo_app/core/utils/app_image_url.dart';
import 'package:todo_app/core/utils/app_string.dart';
import 'package:todo_app/core/utils/custome_snackbar.dart';
import 'package:todo_app/core/utils/full_screen_dialog_loader.dart';
import 'package:todo_app/core/utils/storeage_key.dart';
import 'package:todo_app/core/utils/storeage_service.dart';
import 'package:todo_app/core/utils/validation_rules.dart';
import 'package:todo_app/core/widget/custome_text_form_field.dart';
import 'package:todo_app/core/widget/rounded_button.dart';
import 'package:todo_app/features/auth/cubit/login_cubit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final StoreageService _storeageService = locator<StoreageService>();
  bool isPasswordVisible = false;

  clearText() {
    _emailController.clear();
    _passwordController.clear();
  }

  @override
  void dispose() {
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
            child: BlocConsumer<LoginCubit, LoginState>(
              listener: (context, state) {
                if (state is LoginLoading) {
                  FullScreenDialogLoader.show(context);
                } else if (state is LoginSuccess) {
                  FullScreenDialogLoader.show(context);
                  CustomeSnackbar.showSuccess(context, AppString.sucess);
                  clearText();
                  _storeageService.setValue(
                      StoreageKey.userId, state.session.userId);

                  _storeageService.setValue(
                      StoreageKey.sessionId, state.session.$id);

                  context.goNamed(RoutesName.todo);
                } else if (state is LoginFailure) {
                  FullScreenDialogLoader.cancel(context);
                  CustomeSnackbar.showError(context, state.error);
                }
              },
              builder: (context, state) {
                return Form(
                  key: _loginFormKey,
                  child: Column(
                    children: [
                      Image.asset(
                        AppImageUrl.logo,
                        width: 100,
                        height: 100,
                      ),
                      const SizedBox(
                        height: 20,
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
                        buttonText: AppString.login,
                        onPressed: () {
                          if (_loginFormKey.currentState!.validate()) {
                            context.read<LoginCubit>().login(
                                email: _emailController.text,
                                password: _passwordController.text);
                          }
                        },
                        color: AppColor.appColor,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          context.pushNamed(RoutesName.register);
                        },
                        child: RichText(
                          text: const TextSpan(
                            text: AppString.newUser,
                            style: TextStyle(color: AppColor.greyColor),
                            children: [
                              TextSpan(
                                text: AppString.register,
                                style: TextStyle(
                                    color: AppColor.appColor,
                                    fontWeight: FontWeight.w500),
                              ),
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
