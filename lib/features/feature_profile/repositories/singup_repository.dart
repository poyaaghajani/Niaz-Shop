import 'package:niaz_shopping/common/error_handling/api_exeption.dart';
import 'package:niaz_shopping/common/utils/prefs_manager.dart';
import 'package:niaz_shopping/features/feature_profile/data/datasource/singup_api_provider.dart';
import 'package:niaz_shopping/locator.dart';

class SingupRepository {
  SingupApiProvider apiProvider = locator.get();

  Future<String> fetchSingup(
      String username, String password, String passwordConfirm) async {
    try {
      String id = await apiProvider.singUp(username, password, passwordConfirm);

      if (id.isNotEmpty) {
        PrefsManager.saveId(id);
        print(id);
        return 'unknown error';
      } else {
        return 'unknown error';
      }
    } on ApiExeption {
      return 'unknown error';
    }
  }
}
