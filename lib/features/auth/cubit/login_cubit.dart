import 'package:appwrite/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/locators/locators.dart';
import 'package:todo_app/data/repository/auth_repository.dart';
import 'package:todo_app/error/faiilure.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository = locator<AuthRepository>();
  LoginCubit() : super(LoginInitial());

  void login({required String email, required String password}) async {
    emit(LoginLoading());
    final response =
        await _authRepository.login(email: email, password: password);

       response.fold(
        (Faiilure) => emit(
              LoginFailure(error: Faiilure.message),
            ),
        (session) => emit(LoginSuccess(session: session)));
  }
}
