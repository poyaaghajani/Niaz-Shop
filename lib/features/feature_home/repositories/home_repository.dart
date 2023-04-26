import 'package:dio/dio.dart';
import 'package:niaz_shopping/common/error_handling/app_exception.dart';
import 'package:niaz_shopping/common/error_handling/check_exceptions.dart';
import 'package:niaz_shopping/common/resources/data_state.dart';
import 'package:niaz_shopping/features/feature_home/data/datasource/home_api_provider.dart';
import 'package:niaz_shopping/features/feature_home/data/models/home_model.dart';
import 'package:niaz_shopping/locator.dart';

class HomeRepository {
  HomeApiProvider apiProvider = locator.get();

  Future<dynamic> fetchHomeData() async {
    try {
      Response response = await apiProvider.callHomeData();

      final HomeModel homeModel = HomeModel.fromJson(response.data);

      return DataSuccess(homeModel);
    } on AppException catch (ex) {
      return CheckExceptions.getError(ex);
    }
  }
}
