import 'package:appwrite/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/locators/locators.dart';
import 'package:todo_app/core/utils/storeage_key.dart';
import 'package:todo_app/core/utils/storeage_service.dart';
import 'package:todo_app/data/models/todo_model.dart';
import 'package:todo_app/data/repository/todo_repository.dart';
import 'package:todo_app/error/faiilure.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(TodoInitial());

  final TodoRepository _todoRepository = locator<TodoRepository>();
  final StoreageService _storeageService = locator<StoreageService>();

  void addTodo(
      {required String title,
      required String description,
      required bool isComplete}) async {
    emit(TodoAddEditDeleteLoading());

    final res = await _todoRepository.addTodo(
        userId: _storeageService.getValue(StoreageKey.userId),
        title: title,
        description: description,
        isCompleted: isComplete);

    res.fold(
      (Faiilure) => emit(TodoError(error: Faiilure.message)),
      (document) => emit(TodoAddEditDeleteSuccess()),
    );
  }
}
