import 'package:http/http.dart' as http;

class AuthServiceProvider {
  static const String _apiRootURL = 'https://used-products.herokuapp.com/api';
  static const String _loginPath = '/login';

  // Body Keys
  static const _acceptKey = 'Accept';
  static const _emailKey = 'email';
  static const _passwordKey = 'password';

  // Accept header value
  static const _acceptValue = 'application/json';

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
    } catch (ex) {
      print('error occured while loading data');
      return null;
    }

    print(response.body);

    return response;
  }
}
