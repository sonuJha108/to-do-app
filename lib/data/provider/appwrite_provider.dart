import 'package:appwrite/appwrite.dart';
import 'package:todo_app/core/utils/appwrite_constants.dart';

class AppwriteProvider {
  Client client = Client();
  Account? account;
  Databases? databases;

  AppwriteProvider() {
    client
        .setEndpoint(AppwriteConstants.endpoint)
        .setProject(AppwriteConstants.projectId)
        .setSelfSigned(status: true);
    account = Account(client);
    databases = Databases(client);
  }
}
