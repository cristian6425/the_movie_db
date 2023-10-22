import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalDataSource {

  final FlutterSecureStorage _localDataSource = const FlutterSecureStorage();

  Future<String?> read(String key)=> _localDataSource.read(key: key);

  Future<void> write({required String key, required String value}) => _localDataSource.write(key: key, value: value);

  Future<void> delete(String key) => _localDataSource.delete(key: key);

}