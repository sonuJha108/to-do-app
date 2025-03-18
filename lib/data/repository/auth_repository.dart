abstract interface class IAuthRepository {
  register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  });
}
