import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:niaz_shopping/common/utils/prefs_manager.dart';
import 'package:niaz_shopping/features/feature_home/data/datasource/home_api_provider.dart';
import 'package:niaz_shopping/features/feature_home/repositories/home_repository.dart';
import 'package:niaz_shopping/features/feature_intro/repository/splash_repository.dart';
import 'package:niaz_shopping/features/feature_product/data/datasource/category_api_provider.dart';
import 'package:niaz_shopping/features/feature_product/data/datasource/products_api_provider.dart';
import 'package:niaz_shopping/features/feature_product/repositories/category_repository.dart';
import 'package:niaz_shopping/features/feature_product/repositories/products_repository.dart';
import 'package:niaz_shopping/features/feature_profile/data/datasource/login_api_provider.dart';
import 'package:niaz_shopping/features/feature_profile/data/datasource/singup_api_provider.dart';
import 'package:niaz_shopping/features/feature_profile/repositories/login_repository.dart';
import 'package:niaz_shopping/features/feature_profile/repositories/singup_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt locator = GetIt.instance;

Future<void> getInit() async {
  // components
  locator.registerSingleton<Dio>(Dio());
  SharedPreferences pref = await SharedPreferences.getInstance();
  locator.registerSingleton<SharedPreferences>(pref);
  locator.registerSingleton<PrefsManager>(PrefsManager());

  // ApiProviders
  locator.registerSingleton<HomeApiProvider>(HomeApiProvider());
  locator.registerSingleton<CategoryApiProvider>(CategoryApiProvider());
  locator.registerSingleton<ProductsApiProvider>(ProductsApiProvider());
  locator.registerSingleton<SingupApiProvider>(SingupApiProvider());
  locator.registerSingleton<LoginApiProvider>(LoginApiProvider());

  // repositories
  locator.registerSingleton<ISplashRepository>(SplashRepository());
  locator.registerSingleton<HomeRepository>(HomeRepository());
  locator.registerSingleton<CategoryRepository>(CategoryRepository());
  locator.registerSingleton<ProductsRepository>(ProductsRepository());
  locator.registerSingleton<SingupRepository>(SingupRepository());
  locator.registerSingleton<LoginRepository>(LoginRepository());
}
