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

abstract interface class IAuthRepository {
  Future<Either<Faiilure, User>> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  });

  Future<Either<Faiilure, Session>> login({
    required String email,
    required String password,
  });

  Future<Either<Faiilure, Session>> checkSession();
}

class AuthRepository implements IAuthRepository {
  final AppwriteProvider _appWriteProvider = locator<AppwriteProvider>();
  final InternetConnectionChecker _internetConnectionChecker =
      locator<InternetConnectionChecker>();
  @override
  Future<Either<Faiilure, User>> register(
      {required String firstName,
      required String lastName,
      required String email,
      required String password}) async {
    try {
      if (await _internetConnectionChecker.hasConnection) {
        User user = await _appWriteProvider.account!.create(
            userId: ID.unique(),
            email: email,
            password: password,
            name: "$firstName $lastName");
        await _appWriteProvider.databases!.createDocument(
            databaseId: AppwriteConstants.databaseId,
            collectionId: AppwriteConstants.userCollectionId,
            documentId: user.$id,
            data: {
              "id": user.$id,
              "firstName": firstName,
              "lastName": lastName,
              "fullName": "$firstName $lastName",
              "email": email,
            });
        return right(user);
      } else {
        return left(Faiilure(AppString.internetNotFound));
      }
    } on AppwriteException catch (e) {
      return left(Faiilure(e.message!));
    } on ServerExceptions catch (e) {
      return left(Faiilure(e.message!));
    }
  }

  @override
  Future<Either<Faiilure, Session>> login(
      {required String email, required String password}) async {
    try {
      if (await _internetConnectionChecker.hasConnection) {
        Session session =
            await _appWriteProvider.account!.createEmailPasswordSession(
          email: email,
          password: password,
        );

        return right(session);
      } else {
        return left(Faiilure(AppString.internetNotFound));
      }
    } on AppwriteException catch (e) {
      return left(Faiilure(e.message!));
    } on ServerExceptions catch (e) {
      return left(Faiilure(e.message!));
    }
  }

  @override
  Future<Either<Faiilure, Session>> checkSession() async {
    try {
      if (await _internetConnectionChecker.hasConnection) {
        Session session =
            await _appWriteProvider.account!.getSession(sessionId: "Current ");
        return right(session);
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
