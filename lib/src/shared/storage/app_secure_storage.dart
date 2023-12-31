import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:my_money_app/src/shared/storage/app_keys.dart';

class AppSecureStorage {
  static final FlutterSecureStorage storage = FlutterSecureStorage();

  // We use Future method cause we're manipulating device's local data storage, so it has to be async
  static Future<void> addItem(AppKeys key, String value) async {
    await storage.write(key: key.toString(), value: value);
  }

  static Future<void> deleteItem(AppKeys key) async {
    await storage.delete(key: key.toString());
  }

  static Future<String?> readItem(AppKeys key) async {
    return await storage.read(key: key.toString());
  }
}
