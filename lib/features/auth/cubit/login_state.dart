part of 'login_cubit.dart';

// all the  login  states  are here
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  final Session session;
  LoginSuccess({required this.session});
}

final class LoginFailure extends LoginState {
  final String error;
  LoginFailure({required this.error});
}
