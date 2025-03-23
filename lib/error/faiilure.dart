import 'package:todo_app/core/utils/app_string.dart';

// when the fail of all conditions, errors like server network etc.
class Faiilure {
  final String message;

  Faiilure(String internetNotFound, {this.message = AppString.internalServerError});
}
