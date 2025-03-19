import 'package:todo_app/core/utils/app_string.dart';

class Faiilure {
  final String message;

  Faiilure(String internetNotFound, {this.message = AppString.internalServerError});
}
