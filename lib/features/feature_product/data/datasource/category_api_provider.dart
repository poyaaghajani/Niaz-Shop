import 'package:dio/dio.dart';
import 'package:niaz_shopping/common/error_handling/check_exceptions.dart';
import 'package:niaz_shopping/config/constants.dart';
import 'package:niaz_shopping/locator.dart';

class CategoryApiProvider {
  Dio dio = locator.get();

  dynamic callCategories() async {
    final response = await dio
        .get('${BaseURL.baseUrl}/categories/tree')
        .onError((DioError error, stackTrace) {
      return CheckExceptions.response(error.response!);
    });
    return response;
  }
}
