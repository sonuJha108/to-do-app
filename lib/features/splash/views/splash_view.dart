import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/core/routes/name_routes.dart';
import 'package:todo_app/core/utils/app_image_url.dart';
import 'package:todo_app/core/utils/app_string.dart';
import 'package:todo_app/core/utils/custome_snackbar.dart';
import 'package:todo_app/core/utils/full_screen_dialog_loader.dart';
import 'package:todo_app/features/splash/cubit/splash_cubit.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SplashCubit>().checkSession();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocConsumer<SplashCubit, SplashState>(
          listener: (context, state) {
            if (state is SplashLoading) {
              FullScreenDialogLoader.show(context);
            } else if (state is SplashSuccess) {
              FullScreenDialogLoader.cancel(context);
              context.goNamed(RoutesName.todo);
            } else if (state is SplashError) {
              FullScreenDialogLoader.cancel(context);
              context.goNamed(RoutesName.login);

              CustomeSnackbar.showError(context, state.error);
            }
          },
          builder: (context, state) {
            return Image.asset(
              AppImageUrl.logo,
              width: 80,
              height: 80,
            );
          },
        ),
      ),
    );
  }
}
