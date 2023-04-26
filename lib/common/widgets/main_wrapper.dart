import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niaz_shopping/common/utils/prefs_manager.dart';
import 'package:niaz_shopping/common/widgets/bottom_nav.dart';
import 'package:niaz_shopping/features/feature_basket/presentation/screens/basket_screen.dart';
import 'package:niaz_shopping/features/feature_home/presentation/bloc/home_bloc.dart';
import 'package:niaz_shopping/features/feature_home/presentation/screens/home_screen.dart';
import 'package:niaz_shopping/features/feature_product/presentation/bloc/category_bloc/category_bloc.dart';
import 'package:niaz_shopping/features/feature_product/presentation/screens/category_screen.dart';
import 'package:niaz_shopping/features/feature_profile/presentation/bloc/singup_bloc/singup_bloc.dart';
import 'package:niaz_shopping/features/feature_profile/presentation/screens/profile_screen.dart';
import 'package:niaz_shopping/features/feature_profile/presentation/screens/singup_screen.dart';

// ignore: must_be_immutable
class MainWrapper extends StatelessWidget {
  static const routeName = "/main_wrapper";

  MainWrapper({Key? key}) : super(key: key);

  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNav(controller: pageController),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: pageController,
                children: [
                  BlocProvider(
                    create: (context) => HomeBloc(),
                    child: HomeScreen(),
                  ),
                  BlocProvider(
                    create: (context) => CategoryBloc(),
                    child: const CategoryScreen(),
                  ),
                  if (PrefsManager.readCode().isEmpty) ...[
                    BlocProvider(
                      create: (context) => SingupBloc(),
                      child: const SingupScreen(),
                    ),
                  ] else ...[
                    ProfileScreen()
                  ],
                  const BasketScreen()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
