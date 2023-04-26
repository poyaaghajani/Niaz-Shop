import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:niaz_shopping/config/constants.dart';

class ProductItem extends StatelessWidget {
  final String? name;
  final int? discount;
  final String? price;
  final String? priceBeforDiscount;
  final int? star;
  final dynamic image;
  final double? margin;
  final String? topText;
  const ProductItem({
    super.key,
    required this.name,
    required this.discount,
    required this.price,
    required this.priceBeforDiscount,
    required this.star,
    required this.image,
    required this.margin,
    this.topText,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      margin:
          EdgeInsets.symmetric(horizontal: margin ?? 0, vertical: margin ?? 0),
      width: width / 2,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        color: Colors.white,
      ),
      child: Column(
        children: [
          SizedBox(height: height * 0.01),
          Text(
            topText ?? 'شگفت انگیز اختصاصی اپ',
            style: const TextStyle(
              color: CustomColors.lightAmber,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          SizedBox(height: height * 0.01),
          Expanded(
            child: Center(child: image),
          ),
          SizedBox(height: height * 0.01),
          Text(
            name ?? 'name',
            style: CustomTextStyle.darkMedium,
          ),
          SizedBox(height: height * 0.01),
          Container(
            decoration: const BoxDecoration(
              color: CustomColors.dark,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    /// discount red container
                    (discount != 0)
                        ? Container(
                            width: 40,
                            height: 30,
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: CustomColors.red,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                "$discount%",
                                style: CustomTextStyle.whiteSmall,
                              ),
                            ),
                          )
                        : Container(),

                    const Spacer(),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Text(
                              price ?? '100',
                              style: const TextStyle(
                                  color: CustomColors.lightGrey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13),
                            ),
                            (priceBeforDiscount != "0")
                                ? Text(
                                    priceBeforDiscount!,
                                    style: const TextStyle(
                                      color: CustomColors.lightGrey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                        SizedBox(width: width * 0.01),
                        const Text(
                          'تومان',
                          style: TextStyle(
                              color: CustomColors.lightGrey,
                              fontWeight: FontWeight.bold,
                              fontSize: 10),
                        ),
                        SizedBox(width: width * 0.02),
                      ],
                    ),
                  ],
                ),
                Center(
                  child: RatingBar.builder(
                    unratedColor: Colors.white,
                    itemSize: 20,
                    initialRating: star!.toDouble(),
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
                ),
                SizedBox(height: height * 0.01),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
