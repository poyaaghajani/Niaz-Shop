import 'package:dio/dio.dart';
import 'package:niaz_shopping/common/error_handling/api_exeption.dart';
import 'package:niaz_shopping/config/constants.dart';
import 'package:niaz_shopping/locator.dart';

class LoginApiProvider {
  Dio dio = locator.get();

  Future<String> login(String identity, String password) async {
    try {
      final response = await dio.post(
          '${BaseURL.singUrl}/collections/users/auth-with-password',
          data: {
            'identity': identity,
            'password': password,
          });

      if (response.statusCode == 200) {
        return response.data['token'];
      } else {
        throw ApiExeption(0, 'error');
      }
    } on DioError {
      throw ApiExeption(0, 'error');
    }
  }
}
