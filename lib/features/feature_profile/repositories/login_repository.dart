import 'package:niaz_shopping/common/error_handling/api_exeption.dart';
import 'package:niaz_shopping/common/utils/prefs_manager.dart';
import 'package:niaz_shopping/features/feature_profile/data/datasource/login_api_provider.dart';
import 'package:niaz_shopping/locator.dart';

class LoginRepository {
  LoginApiProvider apiProvider = locator.get();

  Future<String> fetchLogin(String identity, String password) async {
    try {
      String token = await apiProvider.login(identity, password);

      if (token.isNotEmpty) {
        PrefsManager.saveToken(token);
        print(token);
        return 'unknown error';
      } else {
        return 'unknown error';
      }
    } on ApiExeption {
      return 'unknown error';
    }
  }
}
