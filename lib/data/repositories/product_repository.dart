import 'dart:io';

import 'package:products_management/data/content_providers/products_content_provider.dart';
import 'package:products_management/data/models/models.dart';
import 'package:products_management/data/repositories/shared_prefs_repository.dart';

class ProductRepository {
  final ProductsContentProvider _productsProvider;
  final SharedPrefsRepository _prefsRepository;
  ProductRepository({required SharedPrefsRepository prefsRepository})
      : _prefsRepository = prefsRepository,
        _productsProvider = ProductsContentProvider();

  Future<List<Product>?> getAllProucts() async {
    String? token = await _prefsRepository.getAccessToken();

    if (token == null) {
      return null;
    }

    final jsonProducts = await _productsProvider.getAllProducts(token);

    if (jsonProducts == null) {
      return null;
    }

    List<Product> products = [];
    print(jsonProducts); //todo: remove this
    for (var product in jsonProducts) {
      products.add(Product.fromMap(product));
    }
    return products;
  }

/*
 * used to post a product with a post request to the api
 */
  Future<bool> addProduct(Product product) async {
    String? token = await _prefsRepository.getAccessToken();

// if usser is not registered don't store an item
    if (token == null) {
      return false;
    }

    final isDone = await _productsProvider.addProduct(
      token: token,
      product: product, // pass new product data
    );

    return isDone;
  }

  // This function is responsible for uploading images and returning the imageUrl
  Future<String> uploadImage({
    required String filename,
    required File file,
  }) async {
    String? imageUrl = await _productsProvider.uploadImage(
      file: file,
      filename: filename,
    );
    print(imageUrl);

    if (imageUrl == null) {
      throw Exception('Error while uploading the image');
    }

    return imageUrl;
  }

  Future<bool> deleteProudct(int id) async {
    String? token = await _prefsRepository.getAccessToken();

    // if usser is not registered don't delete an item
    if (token == null) {
      return false;
    }

    final isDone = await _productsProvider.deleteProduct(
      token: token,
      productID: id,
    );

    return isDone;
  }
}
