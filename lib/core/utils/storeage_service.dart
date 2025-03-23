import 'package:get_storage/get_storage.dart';

// ofline data in the app.
class StoreageService {

  // store the data in ofline using the get_store package.
  final GetStorage _box = GetStorage();

  // A fuctions is set the values in the offile and store the data.
  // write the data in the offline mode.
  void setValue(String key, String value) {
    _box.write(key, value);
  }

  // A function is any type of value and read the data in offine mode.
  dynamic getValue(String key) {
    return _box.read(key);
  }

  // clear the functions are erase all offline data.
  void clearAll() {
    _box.erase();
  }
}
