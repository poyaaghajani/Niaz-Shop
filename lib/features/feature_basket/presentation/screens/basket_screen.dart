import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:niaz_shopping/common/widgets/cached_image.dart';
import 'package:niaz_shopping/common/widgets/custom_buton.dart';
import 'package:niaz_shopping/config/constants.dart';
import 'package:niaz_shopping/features/feature_basket/data/product_basket.dart';

class BasketScreen extends StatefulWidget {
  const BasketScreen({super.key});

  @override
  State<BasketScreen> createState() => _BasketScreenState();
}

class _BasketScreenState extends State<BasketScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    var box = Hive.box<ProductBasket>('basketBox');

    return Scaffold(
      backgroundColor: CustomColors.backgroundScreenColor,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
            child: Column(
              children: [
                header(width, height),
                basketItem(box, width, height),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            child: CustomButton(
              width: width - 30,
              height: height / 14,
              radius: 12,
              onPressed: () {},
              text: 'ادامه فرآیند خرید',
              textStyle: CustomTextStyle.whiteMedium,
              color: CustomColors.lightAmber,
            ),
          ),
        ],
      ),
    );
  }

  Expanded basketItem(Box<ProductBasket> box, double width, double height) {
    return Expanded(
      child: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (context, value, child) {
          if (box.isEmpty) {
            return Center(
              child: Text(
                'سبد خرید شما درحال حاضر خالی است...',
                style: TextStyle(
                  color: Colors.grey.shade700,
                ),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: box.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                var item = box.values.toList()[index];

                return Container(
                  margin: EdgeInsets.only(
                    bottom: (index == box.values.length - 1) ? 90 : 20,
                    top: 20,
                  ),
                  width: width,
                  height: height / 3.5,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: height / 6,
                              child: CachedImage(
                                imageUrl: item.image,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: height / 20,
                                  width: width / 2,
                                  child: Text(
                                    item.name!,
                                    style: CustomTextStyle.darkLarge,
                                  ),
                                ),
                                Text(
                                  'موجود در انبار نیاز شاپ',
                                  style: TextStyle(
                                      color: Colors.grey.shade800,
                                      fontSize: 13),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'قیمت محصول: ${item.priceBeforDiscount}',
                                  style: TextStyle(color: Colors.grey.shade800),
                                ),
                                const SizedBox(height: 25),
                                Wrap(
                                  spacing: 10,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: CustomColors.dark),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 2),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Text(
                                              'تخفیف',
                                              style: TextStyle(
                                                fontSize: 13,
                                                color: CustomColors.dark,
                                              ),
                                            ),
                                            Text(
                                              ' ${item.discount}%',
                                              style: const TextStyle(
                                                fontSize: 13,
                                                color: CustomColors.dark,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        box.deleteAt(index);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: CustomColors.red),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 2),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const Text(
                                                'حذف',
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  color: CustomColors.red,
                                                ),
                                              ),
                                              Image.asset(
                                                  'assets/images/icon_recyclebin.png')
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Container(
                        width: width,
                        height: height / 12,
                        decoration: const BoxDecoration(
                          color: CustomColors.dark,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '${item.price} تومان',
                            style: CustomTextStyle.whiteMedium,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Container header(double width, double height) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      width: width,
      height: height / 16,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
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
        ],
      ),
    );
  }
}
