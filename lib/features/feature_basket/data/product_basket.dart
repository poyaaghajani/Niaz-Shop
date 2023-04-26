import 'package:hive/hive.dart';

part 'product_basket.g.dart';

@HiveType(typeId: 0)
class ProductBasket {
  @HiveField(0)
  String? image;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? price;
  @HiveField(3)
  String? priceBeforDiscount;
  @HiveField(4)
  int? discount;

  ProductBasket(
    this.image,
    this.name,
    this.price,
    this.priceBeforDiscount,
    this.discount,
  );
}
