import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:niaz_shopping/common/arguments/one_product_argument.dart';
import 'package:niaz_shopping/common/widgets/cached_image.dart';
import 'package:niaz_shopping/common/widgets/custom_buton.dart';
import 'package:niaz_shopping/common/widgets/dot_loading.dart';
import 'package:niaz_shopping/config/constants.dart';
import 'package:niaz_shopping/features/feature_home/data/models/home_model.dart';
import 'package:niaz_shopping/features/feature_home/presentation/bloc/home_bloc.dart';
import 'package:niaz_shopping/features/feature_home/presentation/bloc/home_data_status.dart';
import 'package:niaz_shopping/features/feature_home/presentation/bloc/home_event.dart';
import 'package:niaz_shopping/features/feature_home/presentation/bloc/home_state.dart';
import 'package:niaz_shopping/common/widgets/search_textfield.dart';
import 'package:niaz_shopping/common/widgets/product_item.dart';
import 'package:niaz_shopping/features/feature_product/presentation/screens/product_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/home_screen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController sliderController = PageController(initialPage: 0);
  final PageController bannerController = PageController(initialPage: 0);

  final TextEditingController searchController = TextEditingController();

  Timer? _timer;
  int _currentPage = 0;

  Timer? _timer2;
  int _currentPage2 = 0;

  @override
  void initState() {
    BlocProvider.of<HomeBloc>(context).add(HomeRequest());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {
      _timer!.cancel();
    }
    if (_timer2 != null) {
      _timer2!.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    // get device size
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: CustomColors.backgroundScreenColor,
      body: BlocBuilder<HomeBloc, HomeState>(
        buildWhen: (previous, current) {
          if (previous.homeDataStatus == current.homeDataStatus) {
            return false;
          }
          return true;
        },
        builder: (context, state) {
          if (state.homeDataStatus is HomeDataLoading) {
            return const Center(
              child: DotLOading(),
            );
          }
          if (state.homeDataStatus is HomeDataError) {
            final HomeDataError homeDataError =
                state.homeDataStatus as HomeDataError;

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(homeDataError.errorMessage),
                  CustomButton(
                    onPressed: () {
                      BlocProvider.of<HomeBloc>(context).add(HomeRequest());
                    },
                    color: CustomColors.lightAmber,
                    text: 'تلاش دوباره',
                    textStyle: CustomTextStyle.whiteSmall,
                  ),
                ],
              ),
            );
          }
          if (state.homeDataStatus is HomeDataCompleted) {
            HomeDataCompleted homeDataCompleted =
                state.homeDataStatus as HomeDataCompleted;
            HomeModel homeModel = homeDataCompleted.homeModel;

            _timer ??=
                Timer.periodic(const Duration(seconds: 3), (Timer timer) {
              if (_currentPage < homeModel.data!.sliders!.length - 1) {
                _currentPage++;
              } else {
                _currentPage = 0;
              }

              if (sliderController.positions.isNotEmpty) {
                sliderController.animateToPage(
                  _currentPage,
                  duration: const Duration(milliseconds: 350),
                  curve: Curves.easeIn,
                );
              }
            });

            _timer2 ??=
                Timer.periodic(const Duration(seconds: 3), (Timer timer) {
              if (_currentPage2 < homeModel.data!.banners!.length - 1) {
                _currentPage2++;
              } else {
                _currentPage2 = 0;
              }

              if (bannerController.positions.isNotEmpty) {
                bannerController.animateToPage(
                  _currentPage2,
                  duration: const Duration(milliseconds: 350),
                  curve: Curves.easeIn,
                );
              }
            });

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 2,
                          color: Colors.grey.shade400,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 10, bottom: 10, top: 10),
                      child: SearchTextField(
                        controller: searchController,
                      ),
                    ),
                  ),
                  SizedBox(height: height / 70),

                  // header sliders
                  (homeModel.data!.sliders!.isNotEmpty)
                      ? headerSliders(height, sliderController, homeModel)
                      : Container(),

                  SizedBox(height: height / 100),

                  // header sliders indicator
                  (homeModel.data!.sliders!.length > 1)
                      ? SmoothPageIndicator(
                          controller: sliderController,
                          count: homeModel.data!.sliders!.length,
                          effect: const ExpandingDotsEffect(
                            dotHeight: 10,
                            dotWidth: 10,
                            dotColor: CustomColors.lightGrey,
                            activeDotColor: CustomColors.lightAmber,
                          ),
                        )
                      : Container(),

                  SizedBox(height: height / 70),

                  // categories grid
                  (homeModel.data!.categories!.isNotEmpty)
                      ? categoriesGrid(height, homeModel)
                      : Container(),

                  SizedBox(height: height / 20),

                  const Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'پیشنهادهای ویژه',
                          style: CustomTextStyle.darkLarge,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height / 70),

                  // wonderfullSuggestions
                  (homeModel.data!.suggestionProducts!.isNotEmpty)
                      ? wonderfullSuggestions(height, homeModel, width)
                      : Container(),

                  SizedBox(height: height / 30),

                  // banners
                  (homeModel.data!.banners!.isNotEmpty)
                      ? banners(height, homeModel)
                      : Container(),

                  SizedBox(height: height / 30),
                  const Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'آبمیوه ها',
                          style: CustomTextStyle.darkLarge,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height / 70),

                  // onrange juices
                  orangeJuices(height, homeModel, width),

                  SizedBox(height: height / 30),

                  const Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'میوه های خشک',
                          style: CustomTextStyle.darkLarge,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height / 70),

                  // fruits
                  fruits(height, homeModel, width),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  // fruits
  Container fruits(double height, HomeModel homeModel, double width) {
    return Container(
      color: Colors.grey.shade300,
      height: height / 2.8,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: homeModel.data!.suggestionProducts![2].items!.length,
        itemBuilder: (context, index) {
          var item = homeModel.data!.suggestionProducts![2].items![index];

          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                ProductScreen.routeName,
                arguments: OneProductArgument(
                  id: item.id,
                  image: item.image,
                  name: item.name,
                  price: item.price,
                  priceBeforDiscount: item.priceBeforDiscount,
                  discount: item.discount,
                  specialDiscount: item.specialDiscount,
                  star: item.star,
                  category: item.category,
                ),
              );
            },
            child: ProductItem(
              margin: 10,
              name: item.name,
              discount: item.discount,
              price: item.price,
              priceBeforDiscount: item.priceBeforDiscount,
              star: item.star,
              image: CachedImage(
                radius: 18,
                imageUrl: item.image,
              ),
            ),
          );
        },
      ),
    );
  }

  // onrange juices
  Container orangeJuices(double height, HomeModel homeModel, double width) {
    return Container(
      color: Colors.grey.shade300,
      height: height / 2.8,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: homeModel.data!.suggestionProducts![0].items!.length,
        itemBuilder: (context, index) {
          var item = homeModel.data!.suggestionProducts![0].items![index];

          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                ProductScreen.routeName,
                arguments: OneProductArgument(
                  id: item.id,
                  image: item.image,
                  name: item.name,
                  price: item.price,
                  priceBeforDiscount: item.priceBeforDiscount,
                  discount: item.discount,
                  specialDiscount: item.specialDiscount,
                  star: item.star,
                  category: item.category,
                ),
              );
            },
            child: ProductItem(
              margin: 10,
              name: item.name,
              discount: item.discount,
              price: item.price,
              priceBeforDiscount: item.priceBeforDiscount,
              star: item.star,
              image: CachedImage(
                radius: 18,
                imageUrl: item.image,
              ),
            ),
          );
        },
      ),
    );
  }

  // banners
  SizedBox banners(double height, HomeModel homeModel) {
    return SizedBox(
      height: height / 4.3,
      child: PageView.builder(
        controller: bannerController,
        itemCount: homeModel.data!.banners!.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            child: CachedImage(
              radius: 12,
              fit: BoxFit.fill,
              imageUrl: homeModel.data!.banners![index].image,
            ),
          );
        },
      ),
    );
  }

  // wonderfullSuggestions
  Widget wonderfullSuggestions(
      double height, HomeModel homeModel, double width) {
    return Container(
      color: Colors.grey.shade300,
      height: height / 2.8,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: homeModel.data!.suggestionProducts![1].items!.length + 1,
        itemBuilder: (context, index) {
          var item = homeModel.data!.suggestionProducts![1];

          if (index == 0) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(
                  'assets/images/amazing.svg',
                  width: 120,
                  color: Colors.white,
                ),
                Image.asset(
                  'assets/images/box.png',
                  width: 150,
                ),
              ],
            );
          } else {
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  ProductScreen.routeName,
                  arguments: OneProductArgument(
                    id: item.items![index - 1].id,
                    image: item.items![index - 1].image,
                    name: item.items![index - 1].name,
                    price: item.items![index - 1].price,
                    priceBeforDiscount:
                        item.items![index - 1].priceBeforDiscount,
                    discount: item.items![index - 1].discount,
                    specialDiscount: item.items![index - 1].specialDiscount,
                    star: item.items![index - 1].star,
                    category: item.items![index - 1].category,
                  ),
                );
              },
              child: ProductItem(
                margin: 10,
                name: item.items![index - 1].name,
                discount: item.items![index - 1].discount,
                price: item.items![index - 1].price,
                priceBeforDiscount: item.items![index - 1].priceBeforDiscount,
                star: item.items![index - 1].star,
                image: CachedImage(
                  radius: 18,
                  imageUrl: item.items![index - 1].image,
                ),
              ),
            );
          }
        },
      ),
    );
  }

  // categories grid
  SizedBox categoriesGrid(double height, HomeModel homeModel) {
    return SizedBox(
      height: height / 3.9,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: homeModel.data!.categories!.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 0,
          mainAxisSpacing: 8,
        ),
        itemBuilder: (context, index) {
          return Column(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  child: CachedImage(
                    radius: 8,
                    imageUrl: homeModel.data!.categories![index].img,
                  ),
                ),
              ),
              Text(
                homeModel.data!.categories![index].title!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: CustomColors.dark,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // header sliders
  SizedBox headerSliders(
      double height, PageController pageController, HomeModel homeModel) {
    return SizedBox(
      height: height / 4.3,
      child: PageView.builder(
        controller: pageController,
        itemCount: homeModel.data!.sliders!.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            child: CachedImage(
              radius: 12,
              fit: BoxFit.fill,
              imageUrl: homeModel.data!.sliders![index].img,
            ),
          );
        },
      ),
    );
  }
}
