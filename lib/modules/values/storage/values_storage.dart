import 'package:netguru_task/storage/secure_storage.dart';
import 'package:netguru_task/utility/flavors.dart';

class ValuesStorage {
  ValuesStorage(this.storage);

  final SecureStorage storage;
  final String values = getStorageValuesKey();

  Future<String> getValuesRaw() {
    return storage.readSingleValue(values);
  }

  Future<void> saveValuesRaw(String id) async {
    await storage.writeToStorage(values, id);
  }
}
