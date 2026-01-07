import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageServices {
  
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> writeSecureData( {key,  value}) async {
    await _storage.write(key: key, value: value);
  }

  Future<String?> readSecureData({ key}) async {
    return await _storage.read(key: key);
  }

  Future<void> deleteSecureData({ key}) async {
    await _storage.delete(key: key);
  }
}