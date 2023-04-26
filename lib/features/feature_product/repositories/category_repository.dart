import 'package:dio/dio.dart';
import 'package:niaz_shopping/common/error_handling/app_exception.dart';
import 'package:niaz_shopping/common/error_handling/check_exceptions.dart';
import 'package:niaz_shopping/common/resources/data_state.dart';
import 'package:niaz_shopping/features/feature_product/data/datasource/category_api_provider.dart';
import 'package:niaz_shopping/features/feature_product/data/models/category_model.dart';
import 'package:niaz_shopping/locator.dart';

class CategoryRepository {
  CategoryApiProvider apiProvider = locator.get();

  Future<dynamic> fetchCategoryData() async {
    try {
      Response response = await apiProvider.callCategories();
      final CategoryModel categoriesModel =
          CategoryModel.fromJson(response.data);
      return DataSuccess(categoriesModel);
    } on AppException catch (e) {
      return await CheckExceptions.getError(e);
    }
  }
}
