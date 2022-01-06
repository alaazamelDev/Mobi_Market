import 'package:products_management/data/content_providers/categories_content_provider.dart';
import 'package:products_management/data/models/category.dart';
import 'package:products_management/data/repositories/shared_prefs_repository.dart';

class CategoryRepository {
  // get an instance of preferences repository to get access to local storage and get the categories list
  final SharedPrefsRepository _prefsRepository;
  final CategoriesContentProvider _categoriesProvider =
      CategoriesContentProvider();

  CategoryRepository(this._prefsRepository);

  /*
  * fetch the list of categories from api
 */
  Future<List<Category>?> getAllCategories() async {
    final jsonCategories = await _categoriesProvider.getCategories();

    if (jsonCategories == null) {
      return null;
    }

    List<Category> categories = [];
    print(jsonCategories); //todo: remove this
    for (var category in jsonCategories) {
      categories.add(Category.fromJson(category));
    }
    return categories;
  }

/*
 * insert the categories list into local storage for later use
 */
  Future<void> storeCategoriesToInternalStorage(
          List<Category> categories) async =>
      await _prefsRepository.storeCategories(categories);

/* 
* retrieve all categories stored in loacl storage
*/
  Future<List<Category>> getCategoriesFromInternalStorage() async {
    List<Category>? categories = await _prefsRepository.getCategoriesList();
    if (categories == null) {
      throw Exception('No Categories stored yet');
    }
    return categories;
  }

  Future<bool> hasCategories() async {
    bool hasData = false;
    try {
      hasData = await getAllCategories() != null;
    } catch (e) {
      return false;
    }
    return hasData;
  }
}
