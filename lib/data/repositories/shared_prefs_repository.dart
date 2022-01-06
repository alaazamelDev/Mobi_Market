import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:products_management/data/models/category.dart';

class SharedPrefsRepository {
  // access token key
  final String _tokenKey = 'access-token';
  final FlutterSecureStorage _storage;

  SharedPrefsRepository(FlutterSecureStorage storage) : _storage = storage;

  Future<String?> getAccessToken() async {
    // get the access token from storage
    final token = await _storage.read(key: _tokenKey);
    return token;
  }

  Future<void> saveAccessToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  Future<void> deleteAccessToken() async {
    await _storage.delete(key: _tokenKey);
    await _storage.deleteAll();
  }

  Future<void> storeCategories(List<Category> categories) async {
    // encode list of categories into map of categories then into string
    String encodedCategories = jsonEncode(
      categories.map((category) => category.toJson()).toList(),
    );

    // store categories in local sata storage
    await _storage.write(key: 'categories', value: encodedCategories);
  }

  Future<List<Category>?> getCategoriesList() async {
    // get the categories list form internal storage
    final encodedCategories = await _storage.read(key: 'categories');
    if (encodedCategories == null) {
      return null;
    }
    
    List<Category> categories =
        jsonDecode(encodedCategories).map((jsonCategory) {
      return Category.fromJson(jsonCategory);
    }).toList();
    return categories;
  }
}
