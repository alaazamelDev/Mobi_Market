import 'dart:convert';

import 'package:http/http.dart' as http;

class CategoriesContentProvider {
  // URL data
  //static const String _apiRootURL = 'https://used-products.herokuapp.com/api';
  static const String _apiRootURL = 'http://192.168.1.106:8000/api';
  static const String _categriesPath = '/categories';

  // Request Keys
  static const _acceptKey = 'Accept';

  // Accept header value
  static const _acceptValue = 'application/json';

  Future getCategories() async {
    http.Response response;
    try {
      // pass data in request body of post request method
      response = await http.get(
        Uri.parse(_apiRootURL + _categriesPath),
        headers: {
          _acceptKey: _acceptValue,
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body)['data'];
      }
    } catch (ex) {
      return null;
    }
  }
}
