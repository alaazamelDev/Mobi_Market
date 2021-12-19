import 'dart:convert';

import 'package:http/http.dart' as http;

class AuthServiceProvider {
  static const String _apiRootURL = 'https://used-products.herokuapp.com/api';
  static const String _loginPath = '/login';
  static const String _logoutPath = '/logout';

  // Request Keys
  static const _acceptKey = 'Accept';
  static const _authorizationKey = 'Authorization';
  static const _emailKey = 'email';
  static const _passwordKey = 'password';

  // Accept header value
  static const _acceptValue = 'application/json';

  // Bearer word for authorization header
  static const _bearer = 'Bearer ';

  /*
   * this function takes user's email and password 
   * and encrypt them and pass them as headers for 
   * the api endpoint /login 
   * 
   * References used:
   * Base64 Encryption: http://shorturl.at/jlnN2 
   */
  Future<dynamic> loginUser(String email, String password) async {
    // validate email & password
    if (email.isEmpty || email.isEmpty) {
      return null;
    }

    http.Response response;
    try {
      // pass data in request body of post request method
      response = await http.post(
        Uri.parse(_apiRootURL + _loginPath),
        headers: {
          _acceptKey: _acceptValue,
        },
        body: {
          _emailKey: email,
          _passwordKey: password,
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body)['access_token'];
      }
    } catch (ex) {
      return null;
    }
    return null;
  }

  /*
   * this function takes user's token
   *  pass it as headers for 
   * the api endpoint /logout 
   * */
  Future logoutUser(String token) async {
    if (token.isEmpty) {
      return null;
    }

    http.Response response;
    try {
      response = await http.post(
        Uri.parse(_apiRootURL + _logoutPath),
        headers: {
          _authorizationKey: _bearer + token,
          _acceptKey: _acceptValue,
        },
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body)['message'];
      }
    } catch (ex) {
      return null;
    }
    return null;
  }
}
