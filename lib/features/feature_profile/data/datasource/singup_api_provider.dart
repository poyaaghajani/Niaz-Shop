import 'package:dio/dio.dart';
import 'package:niaz_shopping/common/error_handling/api_exeption.dart';
import 'package:niaz_shopping/config/constants.dart';
import 'package:niaz_shopping/locator.dart';

class SingupApiProvider {
  Dio dio = locator.get();

  Future<String> singUp(
      String username, String password, String passwordConfirm) async {
    try {
      final response =
          await dio.post('${BaseURL.singUrl}/collections/users/records', data: {
        'username': username,
        'password': password,
        'passwordConfirm': passwordConfirm,
      });

      if (response.statusCode == 200) {
        return response.data['id'];
      } else {
        throw ApiExeption(0, 'error');
      }
    } on DioError {
      throw ApiExeption(0, 'error');
    }
  }
}
