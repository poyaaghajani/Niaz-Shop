import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:niaz_shopping/common/cubit/bottom_nav_cubit/bottom_nav_cubit.dart';
import 'package:niaz_shopping/common/cubit/search_box_cubit/search_box_cubit.dart';
import 'package:niaz_shopping/common/widgets/main_wrapper.dart';
import 'package:niaz_shopping/features/feature_basket/data/product_basket.dart';
import 'package:niaz_shopping/features/feature_home/presentation/screens/home_screen.dart';
import 'package:niaz_shopping/features/feature_intro/presentation/cubit/splash_cubit/splash_cubit.dart';
import 'package:niaz_shopping/features/feature_intro/presentation/screens/intro_main_wrapper.dart';
import 'package:niaz_shopping/features/feature_intro/presentation/screens/splash_screen.dart';
import 'package:niaz_shopping/features/feature_product/presentation/screens/all_products_screen.dart';
import 'package:niaz_shopping/features/feature_product/presentation/screens/product_screen.dart';
import 'package:niaz_shopping/features/feature_profile/presentation/screens/login_screen.dart';
import 'package:niaz_shopping/features/feature_profile/presentation/screens/profile_screen.dart';
import 'package:niaz_shopping/locator.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // get service locator
  await getInit();

  // initialize hive
  await Hive.initFlutter();
  Hive.registerAdapter(ProductBasketAdapter());
  await Hive.openBox<ProductBasket>('basketBox');

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SplashCubit()),
        BlocProvider(create: (_) => BottomNavCubit()),
        BlocProvider(create: (_) => SearchBoxCubit()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        IntroMainWrapper.routeName: (context) => IntroMainWrapper(),
        MainWrapper.routeName: (context) => MainWrapper(),
        SplashScreen.routeName: (context) => const SplashScreen(),
        ProfileScreen.routeName: (context) => ProfileScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        AllProductsScreen.routeName: (context) => const AllProductsScreen(),
        ProductScreen.routeName: (context) => const ProductScreen(),
      },
      locale: const Locale("fa", ""),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale("en", ""),
        Locale("fa", ""),
      ],
      theme: ThemeData(fontFamily: 'Vazir'),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
