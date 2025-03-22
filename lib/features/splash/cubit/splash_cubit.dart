// ignore_for_file: non_constant_identifier_names


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/locators/locators.dart';
import 'package:todo_app/data/repository/auth_repository.dart';


part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  final AuthRepository _authRepository = locator<AuthRepository>();

  void checkSession() async {
    emit(SplashLoading());

    final res = await _authRepository.checkSession();

    res.fold((Faiilure) => emit(SplashError(error: Faiilure.message)),
        // ignore: avoid_types_as_parameter_names
        (Session) => emit(SplashSuccess()));
  }
}
