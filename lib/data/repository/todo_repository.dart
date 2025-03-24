import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:fpdart/fpdart.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:todo_app/core/locators/locators.dart';
import 'package:todo_app/core/utils/app_string.dart';
import 'package:todo_app/core/utils/appwrite_constants.dart';
import 'package:todo_app/data/provider/appwrite_provider.dart';
import 'package:todo_app/error/faiilure.dart';
import 'package:todo_app/error/server_exceptions.dart';

abstract interface class ITodoRepository {
  Future<Either<Faiilure, Document>> addTodo({
    required String userId,
    required String title,
    required String description,
    required bool isCompleted,
  });
}

class TodoRepository implements ITodoRepository {
  final AppwriteProvider _appwriteProvider = locator<AppwriteProvider>();
  final InternetConnectionChecker _internetConnectionChecker =
      locator<InternetConnectionChecker>();

  @override
  Future<Either<Faiilure, Document>> addTodo(
      {required String userId,
      required String title,
      required String description,
      required bool isCompleted}) async {
    try {
      if (await _internetConnectionChecker.hasConnection) {
        String documentId = ID.unique();
        Document document = await _appwriteProvider.databases!.createDocument(
            databaseId: AppwriteConstants.databaseId,
            collectionId: AppwriteConstants.todoCollectionId,
            documentId: documentId,
            data: {
              "userId": userId,
              "title": title,
              "description": description,
              "isCompleted": isCompleted,
              "id": documentId,
            });
        return right(document);
      } else {
        return left(Faiilure(AppString.internetNotFound));
      }
    } on AppwriteException catch (e) {
      return left(Faiilure(e.message!));
    } on ServerExceptions catch (e) {
      return left(Faiilure(e.message!));
    }
  }
}
