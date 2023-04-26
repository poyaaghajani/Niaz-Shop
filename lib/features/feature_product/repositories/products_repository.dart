import 'package:dio/dio.dart';
import 'package:niaz_shopping/common/error_handling/app_exception.dart';
import 'package:niaz_shopping/common/error_handling/check_exceptions.dart';
import 'package:niaz_shopping/common/params/products_params.dart';
import 'package:niaz_shopping/common/resources/data_state.dart';
import 'package:niaz_shopping/features/feature_product/data/datasource/products_api_provider.dart';
import 'package:niaz_shopping/features/feature_product/data/models/all_product_model.dart';
import 'package:niaz_shopping/locator.dart';

class ProductsRepository {
  ProductsApiProvider apiProvider = locator.get();

  Future<dynamic> fetchAllProductsData(ProductsParams productsParams) async {
    try {
      Response response = await apiProvider.callAllProducts(productsParams);
      final AllProductsModel allProductsModel =
          AllProductsModel.fromJson(response.data);
      return DataSuccess(allProductsModel);
    } on AppException catch (e) {
      return CheckExceptions.getError(e);
    }
  }

  Future<List<Products>> fetchAllProductsSearch(
      ProductsParams productsParams) async {
    Response response = await apiProvider.callAllProducts(productsParams);
    final AllProductsModel allProductsModel =
        AllProductsModel.fromJson(response.data);
    return allProductsModel.data![0].products!;
  }
}
