import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  SecureStorage(this.storage);

  final FlutterSecureStorage storage;

  Future<void> writeToStorage(String key, String val) async {
    await storage.write(key: key, value: val);
  }

  Future<void> deleteSingleValue(String key) async {
    await storage.delete(key: key);
  }

  Future<void> deleteAllValues() async {
    await storage.deleteAll();
  }

  Future<String> readSingleValue(String key) async {
    final value = await storage.read(key: key);
    return value;
  }

  Future<Map<String, String>> readAllValues() async {
    final allValues = await storage.readAll();
    return allValues;
  }
}
