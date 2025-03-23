// when you got the 505 error in the app.
class ServerExceptions implements Exception {
  final String message;

 const ServerExceptions({required this.message});
}
