import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/locators/locators.dart';
import 'package:todo_app/data/repository/auth_repository.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  AuthRepository _authRepository = locator<AuthRepository>();

  void register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    emit(RegisterLoading());
    final response = await _authRepository.register(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password);
  }
}
