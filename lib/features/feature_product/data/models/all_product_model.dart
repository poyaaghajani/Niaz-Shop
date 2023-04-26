class AllProductsModel {
  AllProductsModel({
    this.data,
  });

  AllProductsModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }
  List<Data>? data;
}

class Data {
  Data({
    this.products,
    this.count,
    this.nextStart,
    this.more,
  });

  Data.fromJson(dynamic json) {
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products?.add(Products.fromJson(v));
      });
    }
    count = json['count'];
    nextStart = json['nextStart'];
    more = json['more'];
  }
  List<Products>? products;
  int? count;
  int? nextStart;
  bool? more;
}

class Products {
  Products({
    this.id,
    this.image,
    this.name,
    this.price,
    this.priceBeforDiscount,
    this.discount,
    this.callStatus,
    this.specialDiscount,
    this.star,
    this.category,
  });

  Products.fromJson(dynamic json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
    price = json['price'];
    priceBeforDiscount = json['priceBeforDiscount'];
    discount = json['discount'];
    callStatus = json['callStatus'];
    specialDiscount = json['specialDiscount'];
    star = json['star'];
    category = json['category'];
  }
  int? id;
  String? image;
  String? name;
  String? price;
  String? priceBeforDiscount;
  int? discount;
  int? callStatus;
  int? specialDiscount;
  int? star;
  String? category;
}
