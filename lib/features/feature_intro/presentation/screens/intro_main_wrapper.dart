import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niaz_shopping/config/constants.dart';
import 'package:niaz_shopping/common/utils/prefs_manager.dart';
import 'package:niaz_shopping/common/widgets/main_wrapper.dart';
import 'package:niaz_shopping/features/feature_intro/presentation/cubit/intro_cubit/intro_cubit.dart';
import 'package:niaz_shopping/features/feature_intro/presentation/cubit/intro_cubit/intro_state.dart';
import 'package:niaz_shopping/features/feature_intro/presentation/widgets/get_start_btn.dart';
import 'package:niaz_shopping/features/feature_intro/presentation/widgets/intro_page.dart';
import 'package:niaz_shopping/locator.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroMainWrapper extends StatelessWidget {
  static const routeName = '/intro_main_wrapper';

  IntroMainWrapper({super.key});

  final List<Widget> introPages = [
    const IntroPage(
      title: 'همه چی اینجا هست',
      description:
          'انواع مواد خوراکی و ارگانیک رو شما میتونید به راحتی در نیاز شاپ پیدا کنید',
      image: 'assets/images/shopping-bags.png',
    ),
    const IntroPage(
      title: 'خریدی امن و آسان',
      description:
          'با نصب اپلیکیشن نیاز شاپ هرکجا که هستی سفارشت رو به صورت آنلاین برامون بفرست و چند دقیقه بعد دم در تحویل بگیر',
      image: 'assets/images/franchise.png',
    ),
    const IntroPage(
      title: 'تخفیف های ویژه',
      description: 'از قرعه کشی ها و تخیفات فوق العادمون هم که نگم برات',
      image: 'assets/images/paper-bag.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    PageController pageController = PageController();

    return BlocProvider(
      create: (context) => IntroCubit(),
      child: Builder(
        builder: (context) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              body: Stack(
                children: [
                  Container(
                    height: height / 1.7,
                    width: width,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 255, 202, 44),
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(150),
                      ),
                    ),
                  ),
                  PageView(
                    onPageChanged: (index) {
                      if (index == 2) {
                        BlocProvider.of<IntroCubit>(context)
                            .changeGetStart(true);
                      } else {
                        BlocProvider.of<IntroCubit>(context)
                            .changeGetStart(false);
                      }
                    },
                    controller: pageController,
                    children: introPages,
                  ),
                  BlocBuilder<IntroCubit, IntroState>(
                    builder: (context, state) {
                      if (state.showGetStart) {
                        return Positioned(
                          bottom: height / 30,
                          right: width / 30,
                          child: GetStartBtn(
                            text: 'شروع کنید',
                            onTap: () {
                              PrefsManager prefsManager = locator.get();
                              prefsManager.changeIntroState();
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                MainWrapper.routeName,
                                (route) => false,
                              );
                            },
                          ),
                        );
                      } else {
                        return Positioned(
                          bottom: height / 30,
                          right: width / 30,
                          child: GetStartBtn(
                            text: 'ورق بزن',
                            onTap: () {
                              if (pageController.page!.toInt() < 2) {
                                if (pageController.page!.toInt() == 1) {
                                  BlocProvider.of<IntroCubit>(context)
                                      .changeGetStart(true);
                                }
                                pageController.animateToPage(
                                  pageController.page!.toInt() + 1,
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.easeIn,
                                );
                              }
                            },
                          ),
                        );
                      }
                    },
                  ),
                  Positioned(
                    bottom: height / 30,
                    left: width / 30,
                    child: DelayedWidget(
                      delayDuration: const Duration(milliseconds: 800),
                      animationDuration: const Duration(seconds: 1),
                      animation: DelayedAnimations.SLIDE_FROM_BOTTOM,
                      child: SmoothPageIndicator(
                        controller: pageController,
                        count: 3,
                        effect: const ExpandingDotsEffect(
                          dotWidth: 10,
                          dotHeight: 10,
                          spacing: 5,
                          dotColor: CustomColors.grey,
                          activeDotColor: CustomColors.lightAmber,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
