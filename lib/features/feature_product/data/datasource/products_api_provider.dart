import 'package:dio/dio.dart';
import 'package:niaz_shopping/common/error_handling/check_exceptions.dart';
import 'package:niaz_shopping/common/params/products_params.dart';
import 'package:niaz_shopping/config/constants.dart';
import 'package:niaz_shopping/locator.dart';

class ProductsApiProvider {
  Dio dio = locator.get();

  dynamic callAllProducts(ProductsParams productsParams) async {
    final response = await dio.post(
      '${BaseURL.baseUrl}/products',
      data: {
        "start": productsParams.start,
        "step": productsParams.step,
        "categories": productsParams.categories,
        "maxPrice": productsParams.maxPrice,
        "minPrice": productsParams.minPrice,
        "sortby": productsParams.sortBy,
        'search': productsParams.search
      },
    ).onError((DioError error, stackTrace) {
      return CheckExceptions.response(error.response!);
    });
    return response;
  }
}
