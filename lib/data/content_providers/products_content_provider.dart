import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:products_management/data/models/models.dart';
import 'package:http_parser/http_parser.dart';

class ProductsContentProvider {
  // URL data
  //static const String _apiRootURL = 'https://used-products.herokuapp.com/api';
  static const String _apiRootURL = 'http://192.168.1.106:8000/api';
  static const String _projectRootURL = 'http://192.168.1.106:8000';
  static const String _productsPath = '/products';
  static const String _imagePath = '/image';

  // Request Keys
  static const _acceptKey = 'Accept';
  static const _authorizationKey = 'Authorization';

  // Accept header value
  static const _acceptValue = 'application/json';

  // Bearer word for authorization header
  static const _bearer = 'Bearer ';

  Future getAllProducts(String accessToken) async {
    http.Response response;
    try {
      // pass data in request body of post request method
      response = await http.get(
        Uri.parse(_apiRootURL + _productsPath),
        headers: {
          _acceptKey: _acceptValue,
          _authorizationKey: _bearer + accessToken,
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body)['data'];
      }
    } catch (ex) {
      return null;
    }
  }

/*
  * This function is rsponsible for sending a post request with required data
  * to store the inserted product.
*/
  Future<bool> addProduct(
      {required String token, required Product product}) async {
    http.Response response;
    try {
      print(product.toMap());
      response = await http.post(
        Uri.parse(_apiRootURL + _productsPath),
        headers: {
          _acceptKey: _acceptValue,
          _authorizationKey: _bearer + token,
        },
        // pass product data in body of request
        body: product.toMap(),
      );

      print('status code: ${response.statusCode} body: ${response.body}');
      if (response.statusCode == 200) {
        return true;
      }
    } catch (ex) {
      throw Exception(ex.toString());
    }
    return false;
  }

  /*
    * This function is responsible for sending a file post requset to store 
    * the image on the server 
   */
  Future<String?> uploadImage({
    required File file,
    required String filename,
  }) async {
    //MultiPart request
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(_apiRootURL + _imagePath),
    );
    Map<String, String> headers = {
      _acceptKey: _acceptValue,
      "Content-type": "multipart/form-data",
    };
    request.files.add(
      http.MultipartFile(
        'image',
        file.readAsBytes().asStream(),
        file.lengthSync(),
        filename: filename,
        contentType: MediaType('image', 'jpeg'),
      ),
    );
    request.headers.addAll(headers);

    print("request: " + request.toString());
    var res = await request.send();
    var jsonResponse = await res.stream.bytesToString();
    print("This is response:" + res.statusCode.toString());
    print("This is response:" + jsonResponse);

    // check the response
    if (res.statusCode == 200) {
      // uploading success
      print('Uploaded!...');

      String _storagePath = '/storage';
      String _filename = jsonDecode(jsonResponse)['image_name'];
      print(_projectRootURL + ' ' + _storagePath + ' ' + _filename);

      return _projectRootURL + _storagePath + '/$_filename';
    }

    return null;
  }
}
