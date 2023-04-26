import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:niaz_shopping/config/constants.dart';
import 'package:niaz_shopping/common/cubit/bottom_nav_cubit/bottom_nav_cubit.dart';

class BottomNav extends StatelessWidget {
  final PageController controller;

  const BottomNav({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 5,
      color: Colors.white,
      child: SizedBox(
        height: height / 14,
        child: BlocBuilder<BottomNavCubit, int>(
          builder: (context, int state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: width / 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              BlocProvider.of<BottomNavCubit>(context)
                                  .changeSelectedIndex(0);
                              controller.animateToPage(0,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut);
                            },
                            child: Image.asset(
                              state == 0
                                  ? "assets/images/home_icon.png"
                                  : "assets/images/home_icon2.png",
                              color: state == 0
                                  ? CustomColors.lightAmber
                                  : Colors.grey.shade700,
                              width: 33,
                            ),
                          ),
                          Text(
                            'نیاز شاپ',
                            style: state == 0
                                ? CustomTextStyle.selectedBottomNav
                                : CustomTextStyle.bottomNav,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              BlocProvider.of<BottomNavCubit>(context)
                                  .changeSelectedIndex(1);
                              controller.animateToPage(1,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut);
                            },
                            child: Image.asset(
                              state == 1
                                  ? "assets/images/category_icon.png"
                                  : "assets/images/category_icon2.png",
                              color: state == 1
                                  ? CustomColors.lightAmber
                                  : Colors.grey.shade700,
                              width: 33,
                            ),
                          ),
                          Text(
                            'دسته بندی',
                            style: state == 1
                                ? CustomTextStyle.selectedBottomNav
                                : CustomTextStyle.bottomNav,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: width / 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              BlocProvider.of<BottomNavCubit>(context)
                                  .changeSelectedIndex(2);
                              controller.animateToPage(2,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut);
                            },
                            child: SvgPicture.asset(
                              state == 2
                                  ? "assets/images/person_icon.svg"
                                  : "assets/images/person_icon2.svg",
                              color: state == 2
                                  ? CustomColors.lightAmber
                                  : Colors.grey.shade700,
                              width: 33,
                            ),
                          ),
                          Text(
                            'حساب کاربری',
                            style: state == 2
                                ? CustomTextStyle.selectedBottomNav
                                : CustomTextStyle.bottomNav,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              BlocProvider.of<BottomNavCubit>(context)
                                  .changeSelectedIndex(3);
                              controller.animateToPage(3,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut);
                            },
                            child: FaIcon(
                              state == 3
                                  ? Icons.shopping_cart
                                  : Icons.shopping_cart_outlined,
                              color: state == 3
                                  ? CustomColors.lightAmber
                                  : Colors.grey.shade700,
                              size: 33,
                            ),
                          ),
                          Text(
                            'سبد خرید',
                            style: state == 3
                                ? CustomTextStyle.selectedBottomNav
                                : CustomTextStyle.bottomNav,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
