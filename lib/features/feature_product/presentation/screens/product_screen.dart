import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hive/hive.dart';
import 'package:niaz_shopping/common/arguments/one_product_argument.dart';
import 'package:niaz_shopping/common/utils/custom_snackbar.dart';
import 'package:niaz_shopping/common/widgets/cached_image.dart';
import 'package:niaz_shopping/config/constants.dart';
import 'package:niaz_shopping/features/feature_basket/data/product_basket.dart';

class ProductScreen extends StatelessWidget {
  static const routeName = '/product_screen';

  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final arg =
        ModalRoute.of(context)!.settings.arguments as OneProductArgument;

    return Scaffold(
      backgroundColor: CustomColors.backgroundScreenColor,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 10, left: 15, right: 15),
          child: Column(
            children: [
              header(width, height, context),
              SizedBox(height: height / 8),
              SizedBox(
                height: height / 4,
                width: width / 2,
                child: CachedImage(
                  radius: 24,
                  imageUrl: arg.image,
                ),
              ),
              SizedBox(height: height / 100),
              RatingBar.builder(
                unratedColor: Colors.white,
                itemSize: 30,
                initialRating: arg.star!.toDouble(),
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemBuilder: (context, _) {
                  return const Icon(
                    Icons.star,
                    color: CustomColors.lightAmber,
                    size: 10,
                  );
                },
                onRatingUpdate: (rating) {},
              ),
              SizedBox(height: height / 20),
              Text(
                arg.name!,
                style: const TextStyle(
                  fontSize: 30,
                  fontFamily: 'mr',
                  color: CustomColors.dark,
                ),
              ),
              SizedBox(height: height / 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'قیمت اصلی محصول:',
                    style: TextStyle(
                      color: Colors.grey.shade800,
                      fontSize: 17,
                    ),
                  ),
                  Text(
                    '${arg.priceBeforDiscount!} تومان',
                    style: TextStyle(
                      color: Colors.grey.shade800,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              SizedBox(height: height / 70),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'قیمت محصول با تخفیف:',
                    style: TextStyle(
                      color: Colors.grey.shade800,
                      fontSize: 17,
                    ),
                  ),
                  Text(
                    '${arg.price!} تومان',
                    style: TextStyle(
                      color: Colors.grey.shade800,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              addButton(width, height, arg, context),
              SizedBox(height: height / 40),
            ],
          ),
        ),
      ),
    );
  }

  Stack addButton(double width, double height, OneProductArgument arg,
      BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      clipBehavior: Clip.none,
      children: [
        Container(
          width: width - 80,
          height: height / 13,
          decoration: BoxDecoration(
            color: CustomColors.green,
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        Positioned(
          top: 5,
          child: ClipRRect(
            // ignore: sort_child_properties_last
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: GestureDetector(
                onTap: () {
                  final box = Hive.box<ProductBasket>('basketBox');

                  var item = ProductBasket(
                    arg.image,
                    arg.name,
                    arg.price,
                    arg.priceBeforDiscount,
                    arg.discount,
                  );

                  box.add(item);

                  CustomSnackbar.showSnack(
                    context,
                    '${arg.name} به سبد خرید اضافه شد',
                    Colors.white,
                    CustomColors.dark,
                  );
                },
                child: Container(
                  height: height / 12,
                  width: width - 60,
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Container(
                              width: 40,
                              height: 30,
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: CustomColors.red,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 2,
                                    offset: const Offset(0, 6),
                                    color: CustomColors.red.withOpacity(0.4),
                                  )
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  "${arg.discount}%",
                                  style: CustomTextStyle.whiteSmall,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Text(
                          'افزودن سبد خرید',
                          style: CustomTextStyle.whiteMedium,
                        ),
                        SizedBox(width: width / 9),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ],
    );
  }

  Container header(double width, double height, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      width: width,
      height: height / 16,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(
              'assets/images/arrow_back.png',
              color: CustomColors.lightAmber,
            ),
          ),
          const Row(
            children: [
              Text(
                'نیاز',
                style: TextStyle(
                  fontFamily: 'mr',
                  fontSize: 18,
                  color: CustomColors.lightAmber,
                ),
              ),
              Text(
                'شاپ',
                style: TextStyle(
                  fontFamily: 'mr',
                  fontSize: 18,
                ),
              ),
            ],
          ),
          SizedBox(width: width / 22),
        ],
      ),
    );
  }
}
