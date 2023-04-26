import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niaz_shopping/common/widgets/custom_buton.dart';
import 'package:niaz_shopping/common/widgets/dot_loading.dart';
import 'package:niaz_shopping/config/constants.dart';
import 'package:niaz_shopping/common/utils/prefs_manager.dart';
import 'package:niaz_shopping/common/widgets/main_wrapper.dart';
import 'package:niaz_shopping/features/feature_intro/presentation/cubit/splash_cubit/connection_status.dart';
import 'package:niaz_shopping/features/feature_intro/presentation/cubit/splash_cubit/splash_cubit.dart';
import 'package:niaz_shopping/features/feature_intro/presentation/cubit/splash_cubit/splash_state.dart';
import 'package:niaz_shopping/features/feature_intro/presentation/screens/intro_main_wrapper.dart';
import 'package:niaz_shopping/locator.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = "/splash_screen";

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    BlocProvider.of<SplashCubit>(context).checkConnectionState();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: CustomColors.backgroundScreenColor,
      body: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: height,
            width: width,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DelayedWidget(
                delayDuration: const Duration(milliseconds: 200),
                animationDuration: const Duration(milliseconds: 1000),
                animation: DelayedAnimations.SLIDE_FROM_BOTTOM,
                child: Text(
                  'نیاز',
                  style: TextStyle(
                    fontSize: width / 5.5,
                    fontFamily: 'mr',
                    color: CustomColors.lightAmber,
                  ),
                ),
              ),
              DelayedWidget(
                delayDuration: const Duration(milliseconds: 800),
                animationDuration: const Duration(milliseconds: 1000),
                animation: DelayedAnimations.SLIDE_FROM_BOTTOM,
                child: Text(
                  'شاپ',
                  style: TextStyle(fontSize: width / 5.5, fontFamily: 'mr'),
                ),
              ),
            ],
          ),
          BlocConsumer<SplashCubit, SplashState>(
            builder: (context, state) {
              if (state.connectionStatus is ConnectionInit ||
                  state.connectionStatus is ConnectionON) {
                return Positioned(
                  bottom: 5,
                  child: DelayedWidget(
                    delayDuration: const Duration(milliseconds: 800),
                    animationDuration: const Duration(milliseconds: 1000),
                    animation: DelayedAnimations.SLIDE_FROM_BOTTOM,
                    child: const DotLOading(),
                  ),
                );
              }
              if (state.connectionStatus is ConnectionOFF) {
                BlocProvider.of<SplashCubit>(context).checkConnectionState();
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      '!..به اینترنت متصل نیستید',
                      style: TextStyle(
                        color: CustomColors.red,
                      ),
                    ),
                    CustomButton(
                      onPressed: () {
                        BlocProvider.of<SplashCubit>(context)
                            .checkConnectionState();
                      },
                      text: 'تلاش دوباره',
                      textStyle: CustomTextStyle.whiteSmall,
                      color: CustomColors.lightAmber,
                    )
                  ],
                );
              }
              return Container();
            },
            listener: (context, state) {
              if (state.connectionStatus is ConnectionON) {
                goToNextScreen();
              }
            },
          ),
        ],
      ),
    );
  }

  Future<void> goToNextScreen() async {
    PrefsManager prefsManager = locator.get();
    var showIntro = await prefsManager.getIntroState();

    return Future.delayed(
      const Duration(seconds: 3),
      () {
        if (showIntro) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            IntroMainWrapper.routeName,
            (route) => false,
          );
        } else {
          Navigator.pushNamedAndRemoveUntil(
            context,
            MainWrapper.routeName,
            (route) => false,
          );
        }
      },
    );
  }
}
